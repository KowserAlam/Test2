import 'package:skill_check/features/assessment/providers/submit_provider.dart';
import 'package:skill_check/features/assessment/views/time_out_screen.dart';
import 'package:skill_check/features/assessment/views/widgets/candidate_examinfo_widget.dart';
import 'package:skill_check/features/assessment/views/widgets/mark_for_review_button_widget.dart';
import 'package:skill_check/features/assessment/views/widgets/question_text_widget.dart';
import 'package:skill_check/features/assessment/views/widgets/option_tile_widget_for_exam.dart';
import 'package:skill_check/features/assessment/views/widgets/exam_clock_bar_widget.dart';
import 'package:skill_check/features/assessment/views/widgets/review_sidebar_grid_view.dart';
import 'package:skill_check/features/assessment/views/widgets/sidebar_indicator_item.dart';
import 'package:skill_check/features/config/config_provider.dart';
import 'package:skill_check/features/enrolled_exam_list_screen/models/enrolled_exam_model.dart';
import 'package:skill_check/features/home_screen/views/widgets/fail_to_load_data_error_widget.dart';
import 'package:skill_check/main_app/util/json_keys.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../models/candidate_exam_model.dart';
import '../models/questions_model.dart';
import 'package:skill_check/features/assessment/providers/exam_provider.dart';

import 'package:skill_check/features/assessment/views/result_screen.dart';
import 'package:skill_check/main_app/util/app_theme.dart';
import 'package:skill_check/main_app/util/strings_utils.dart';
import 'package:skill_check/main_app/util/cosnt_style.dart';

import 'package:skill_check/main_app/widgets/custom_alert_dialog.dart';
import 'package:skill_check/main_app/widgets/gredient_buton.dart';
import 'package:skill_check/main_app/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:http/http.dart' as http;
import 'package:wakelock/wakelock.dart';

class ExamScreen extends StatefulWidget {
  final EnrolledExamModel enrolledExamModel;

  ExamScreen({@required this.enrolledExamModel});

  @override
  _ExamScreenState createState() => _ExamScreenState(this.enrolledExamModel);
}

class _ExamScreenState extends State<ExamScreen>
    with TickerProviderStateMixin, AfterLayoutMixin {
  final EnrolledExamModel enrolledExamModel;

  _ExamScreenState(
    this.enrolledExamModel,
  );

  TabController _tabControllerSideBar;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;
  int currentTabIndex = 0;

  @override
  void initState() {
    _tabControllerSideBar = TabController(length: 2, vsync: this);
    super.initState();
  }

  ///  after layout form AfterLayoutMixin work like initState() but provide BuildContext
  @override
  void afterFirstLayout(BuildContext context) {
    /// Wakelock.enable keep screen on

    try {
      Wakelock.enable();
    } catch (e) {
      print(e);
    }

    /// fetching question then initializing tab controller  with question  length then starting clock

   print(enrolledExamModel.id);
    Provider.of<ExamProvider>(context, listen: false)
        .getQuestionData("${enrolledExamModel.id}")
        .then((length) {
      if (length != null) {
        _tabController = TabController(length: length, vsync: this);

        /// Start exam clock
        Duration duration = widget.enrolledExamModel.examDurationMinutes;
        Provider.of<ExamProvider>(context, listen: false)
            .startExamClock(duration);
      }
    });
  }

  _handleSubmit(context) async {
    var submitProvider = Provider.of<SubmitProvider>(context, listen: false);
    submitProvider.isSubmitting = true;

    submitProvider
        .handleSubmit(context, "${enrolledExamModel.id}")
        .then((isSuccess) {
      submitProvider.isSubmitting = false;
      if (isSuccess) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ResultScreen()),
        );
      } else {
        _showSnackBar(StringUtils.tryAgainText, Colors.red);
      }
    }).catchError((e) {
      print(e);
      _showSnackBar(StringUtils.tryAgainText, Colors.red);
      submitProvider.isSubmitting = false;
    });
  }

  bool checkNUpdateLastQuestionVisited() {
    if (_tabController != null) if (_tabController.index ==
        _tabController.length - 1) {
      var examProvider = Provider.of<ExamProvider>(context, listen: false);
      examProvider.isLastQuestionVisited = true;
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    bool isTabLayout = MediaQuery.of(context).size.width > 800;
    return WillPopScope(
      onWillPop: () async {
        if (_scaffoldKey.currentState.isDrawerOpen) {
          return true;
        }
        return _quitExamPrompt(context);
      },
      child: ModalProgressHUD(
        progressIndicator: Loader(),
        inAsyncCall: Provider.of<SubmitProvider>(context).isSubmitting,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: isTabLayout ? false : true,
            centerTitle: true,
            title: Text(StringUtils.examText),
            actions: <Widget>[
              Consumer<ConfigProvider>(
                  builder: (context, configProvider, child) {
                return IconButton(
                  icon: configProvider.isDarkModeOn
                      ? Icon(
                          FontAwesomeIcons.lightbulb,
                          size: 20,
                        )
                      : Icon(
                          FontAwesomeIcons.solidLightbulb,
                          size: 20,
                        ),
                  onPressed: configProvider.toggleThemeChangeEvent,
                );
              }),
              IconButton(
                onPressed: () {
                  if (_scaffoldKey.currentState.isDrawerOpen) {
                    Navigator.pop(context);
                  }
                  _quitExamPrompt(context).then((value) {
                    if (value) {
                      Navigator.pop(context);
                    }
                  });
                },
                icon: Icon(Icons.exit_to_app),
              ),
            ],
          ),
          drawer: !isTabLayout
              ? Drawer(
                  child: _buildSideMenu(context),
                )
              : null,
          body: SafeArea(
              child: isTabLayout
                  ? Container(
                      child: Column(
                        children: <Widget>[
                          CandidateExamInfoWidget(
                            enrolledExamModel: enrolledExamModel,
                          ),
                          Divider(),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 300,
                                  child: _buildSideMenu(context),
                                ),
                                Expanded(
                                  child: _buildExamBody(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: <Widget>[
                          CandidateExamInfoWidget(
                            enrolledExamModel: enrolledExamModel,
                          ),
                          Expanded(child: _buildExamBody(context)),
                        ],
                      ),
                    )),
        ),
      ),
    );
  }

  Widget _buildSideMenu(BuildContext context) {
    var examProvider = Provider.of<ExamProvider>(context);
    bool isTabLayout = MediaQuery.of(context).size.width > 720;
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          isTabLayout
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
          TabBar(
            labelColor: Theme.of(context).primaryColor,
            labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            controller: _tabControllerSideBar,
            tabs: <Widget>[
              Tab(
                child: Text(StringUtils.allText),
              ),
              Tab(
                child: Text(StringUtils.reviewText),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabControllerSideBar,
              children: <Widget>[
                //all
                Consumer<ExamProvider>(builder: (context, examProvider, c) {
                  if (examProvider.questionList != null &&
                      _tabController != null) {
                    if (_tabController.index == _tabController.length - 1) {
                      examProvider.isLastQuestionVisited = true;
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ReviewSideBarGridView(
                        questionList: examProvider.questionList,
                        selectedTabIndex: _tabController.index,
                        onTap: (int index) {
                          examProvider.currentQuestionIndex = index;
                          _tabController.animateTo(index);

                          if (!isTabLayout) Navigator.pop(context);
                        },
                      ),
                    );
                  } else
                    return Container();
                }),

                //Review only
                Consumer<ExamProvider>(builder: (context, examProvider, c) {
                  if (examProvider.questionList != null &&
                      _tabController != null) {
                    List<QuestionModel> questionList = [];
                    List<int> indexList = [];
                    int selectdIndex = 0;
                    examProvider.questionList.forEach((questionModel) {
                      if (questionModel.isMarkedForReview ||
                          questionModel.selectedAnswers.isEmpty) {
                        questionList.add(questionModel);
                        indexList.add(questionModel.questionNumber);
                      }
                    });

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ReviewSideBarGridView(
                        questionList: questionList,
                        selectedTabIndex: indexList
                            .indexWhere((i) => i == _tabController.index),
                        onTap: (int index) {
                          _tabController
                              .animateTo(questionList[index].questionNumber);
                          examProvider.currentQuestionIndex =
                              questionList[index].questionNumber;

                          if (!isTabLayout) Navigator.pop(context);
                        },
                      ),
                    );
                  } else
                    return Container();
                }),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border(top: BorderSide())),
            child: Column(
              children: <Widget>[
                SidebarIndicatorItem(
                    label: StringUtils.attemptedText,
                    color: AppTheme.attemptedColor),
                SidebarIndicatorItem(
                    label: StringUtils.notAttemptedText,
                    color: AppTheme.notAttemptedColor),
                SidebarIndicatorItem(
                    label: StringUtils.markedForReviewText,
                    color: AppTheme.markedForReviewColor,
                    isCircle: true),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: GradientButton(
              label: StringUtils.finishExamButtonText,
              onTap: examProvider.isLastQuestionVisited ||
                      checkNUpdateLastQuestionVisited()
                  ? () {
                      /// pop side drawer in mobile screen
                      if (MediaQuery.of(context).size.width < 720) {
                        Navigator.pop(context);
                      }
                      _showSubmitConfirmDialog(context);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamBody(BuildContext context) {
    bool isTabLayout = MediaQuery.of(context).size.width > 720;
    return Consumer<ExamProvider>(builder: (context, examProvider, c) {
      /// show error message when any error found
      if (examProvider.hasError) {
        return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: FailToLoadDataErrorWidget(
            child: Text(
              "Tap here to exit !",
              style:
                  TextStyle(fontSize: 26, color: Colors.grey.withOpacity(0.5)),
            ),
            onTap: () {
              Navigator.pop(context);
              Provider.of<ExamProvider>(context,listen: false).resetState();
            },
          ),
        );
      }

      if (examProvider.questionList != null && _tabController != null) {
        List<QuestionModel> questionList = List.from(examProvider.questionList);
        int questionCount = examProvider.questionList.length;

        return Column(
          children: <Widget>[
            /// exam clock bar
            ExamClockBarWidget(
              enrolledExamModel: enrolledExamModel,
              questionLength: questionCount,
              timeOutCallBack: () {
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    builder: (context) =>
                        TimeOutScreen(widget.enrolledExamModel)));
              },
            ),

            /// exam question and answer section
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: List.generate(questionCount, (tabViewIndex) {
                  List<Answers> correctAnswers = List.from(
                      questionList[tabViewIndex].selectedAnswers ?? []);
                  List<Answers> options =
                      List.from(questionList[tabViewIndex].options ?? []);
                  bool isMarkedForReview =
                      questionList[tabViewIndex].isMarkedForReview ?? false;

                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10),

                                /// Question widget
                                QuestionTextWidget(
                                  questionNumber: tabViewIndex + 1,
                                  question: examProvider
                                      .questionList[tabViewIndex].question,
                                ),
                                Divider(height: 10),
                                //Answers

                                /// Options for chose
                                Column(
                                  children: List.generate(options.length,
                                      (optionIndex) {
                                    bool isRadio = questionList[tabViewIndex]
                                            .questionType ==
                                        JsonKeys.radio;
                                    return InkWell(
                                      onTap: () {

                                        examProvider.ontTapOption(
                                            optionIndex: optionIndex,
                                            isRadio: isRadio,
                                            tabIndex: tabViewIndex);
                                      },
                                      child: OptionTileWidgetForExam(
                                        isCheckBox: !isRadio,
                                        option: options[optionIndex].name,
                                        index: optionIndex,
                                        isSelected: correctAnswers
                                            .contains(options[optionIndex]),
                                      ),
                                    );
                                  }),
                                ),
                                //Mark for review
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// Buttons
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              //Prev Question
                              (tabViewIndex != 0)
                                  ? GradientButton(
                                      label: StringUtils.prevQuestionText,
                                      onTap: () {
                                        currentTabIndex = _tabController.index;

                                        if (currentTabIndex > 0) {
                                          _tabController
                                              .animateTo(currentTabIndex - 1);
                                        } else {
                                          _tabController.animateTo(
                                              questionList.length - 1);
                                        }
                                        examProvider.currentQuestionIndex =
                                            currentTabIndex - 1;

//
                                      })
                                  : GradientButton(
                                      label: StringUtils.prevQuestionText,
                                      onTap: null),

                              ///Mark for review !
                              MarkForReviewButtonWidget(
                                isMarkedForReview: isMarkedForReview,
                                onTap: () {
                                  isMarkedForReview = !isMarkedForReview;
                                  questionList[tabViewIndex].isMarkedForReview =
                                      isMarkedForReview;

                                  Provider.of<ExamProvider>(context,listen: false)
                                      .questionList = questionList;
                                },
                              ),

                              //Next Button
                              (tabViewIndex != questionList.length - 1)
                                  ? GradientButton(
                                      label: StringUtils.nextQuestionText,
                                      onTap: () {
                                        currentTabIndex = _tabController.index;
                                        if (currentTabIndex <
                                            questionList.length - 1) {
                                          _tabController
                                              .animateTo(1 + currentTabIndex);
                                        } else {
                                          _tabController.animateTo(0);
                                        }
                                        examProvider.currentQuestionIndex =
                                            currentTabIndex + 1;
                                      },
                                    )
                                  : GradientButton(
                                      label: StringUtils.nextQuestionText,
                                      onTap: null,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        );
      } else
        return Center(
          child: Loader(),
        );
    });
  }

  _showSnackBar(String text, Color color) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(milliseconds: 600),
      content: Text(
        text,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
    ));
  }

  Future<bool> _quitExamPrompt(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text(StringUtils.doYouWantToQuitExamApp),
            content: new Text(
              StringUtils.yourProgressWillBeLost,
              style: TextStyle(color: Colors.redAccent),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  StringUtils.noText,
                  style: TextStyle(
                      fontSize: 18, color: Theme.of(context).primaryColor),
                ),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Provider.of<ExamProvider>(context, listen: false)
                      .resetState();
                  Wakelock.disable();
                  return true;
                },
                child: new Text(
                  StringUtils.yesText,
                  style: TextStyle(
                      fontSize: 18, color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showSubmitConfirmDialog(context) async {
    await showDialog(
      context: _scaffoldKey.currentContext,
      builder: (BuildContext context) => CustomAlertDialog(
        contentPadding: EdgeInsets.all(20),
        content: Container(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                StringUtils.doYouWantToSubmitText,
                style: kTitleTextBlackStyle.apply(fontSizeFactor: 1.2),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GradientButton(
                    label: StringUtils.noText,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GradientButton(
                    label: StringUtils.yesText,
                    onTap: () {
                      _handleSubmit(_scaffoldKey.currentContext);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

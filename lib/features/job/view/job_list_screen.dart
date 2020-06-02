import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/auth/view/login_screen.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/models/sort_item.dart';
import 'package:p7app/features/job/repositories/job_list_sort_items_repository.dart';
import 'package:p7app/features/job/view/applied_job_list_screen.dart';
import 'package:p7app/features/job/view/favourite_job_list_screen.dart';
import 'package:p7app/features/job/view/job_details.dart';
import 'package:p7app/features/job/view/widgets/filter_preview_widget.dart';
import 'package:p7app/features/job/view/widgets/job_list_filters_widget.dart';
import 'package:p7app/features/job/view_model/job_list_filter_widget_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/features/job/view/widgets/job_list_tile_widget.dart';
import 'package:p7app/features/user_profile/models/skill.dart';
import 'package:p7app/features/user_profile/repositories/skill_list_repository.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/flavour/flavor_banner.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/widgets/common_prompt_dialog.dart';
import 'package:p7app/main_app/widgets/custom_text_field.dart';
import 'package:p7app/main_app/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/widgets/failure_widget.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:p7app/main_app/widgets/toggle_app_theme_widget.dart';
import 'package:provider/provider.dart';

class JobListScreen extends StatefulWidget {
  JobListScreen({Key key}) : super(key: key);

  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen>
    with AfterLayoutMixin, TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  AnimationController controller;
  TextEditingController _searchTextEditingController = TextEditingController();
  var _searchFieldFocusNode = FocusNode();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  TabController _tabViewController;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
      reverseDuration: Duration(milliseconds: 400),
    );
    _tabViewController = TabController(
      vsync: this,
      length: 3,
    );

    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    var jobListViewModel =
        Provider.of<JobListViewModel>(context, listen: false);
    jobListViewModel.getJobList(isFormOnPageLoad: true).then((v) {
      if (jobListViewModel.appError != null) {
        if (jobListViewModel.appError == AppError.unauthorized) {
          _signOut(context);
        }
      }
    });

    if(jobListViewModel.hasSearchQuery){
      _searchTextEditingController.text = jobListViewModel.jobListFilters.searchQuery;
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        jobListViewModel.getMoreData();
      }
    });

    _tabViewController.addListener(() {
//  print("changing ${_tabViewController.index} ");
      setState(() {});
    });
  }

  _signOut(context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    AuthService.getInstance().then((value) => value.removeUser());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabViewController.dispose();
    super.dispose();
  }

  errorWidget() {
    var jobListViewModel =
        Provider.of<JobListViewModel>(context, listen: false);
    switch (jobListViewModel.appError) {
      case AppError.serverError:
        return FailureFullScreenWidget(
          errorMessage: StringUtils.unableToLoadData,
          onTap: () {
            return Provider.of<JobListViewModel>(context, listen: false)
                .refresh();
          },
        );

      case AppError.networkError:
        return FailureFullScreenWidget(
          errorMessage: StringUtils.checkInternetConnectionMessage,
          onTap: () {
            return Provider.of<JobListViewModel>(context, listen: false)
                .refresh();
          },
        );

      case AppError.unauthorized:
        return FailureFullScreenWidget(
          errorMessage: StringUtils.somethingIsWrong,
          onTap: () {
            return _signOut(context);
          },
        );

      default:
        return FailureFullScreenWidget(
          errorMessage: StringUtils.somethingIsWrong,
          onTap: () {
            return Provider.of<JobListViewModel>(context, listen: false)
                .refresh();
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    var scaffoldBackgroundColor = Theme.of(context).backgroundColor;

    return Consumer<JobListViewModel>(builder: (context, jobListViewModel, _) {

      bool isMainList = _tabViewController.index == 0;
      var jobList = jobListViewModel.jobList;
      var isInSearchMode = jobListViewModel.isInSearchMode;
//      debugPrint("${jobList.length}");
      var searchInputWidget = Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: CustomTextField(
              textInputAction: TextInputAction.search,
              focusNode: _searchFieldFocusNode,
              onChanged: (v)=>jobListViewModel.jobListFilters.searchQuery,
              onSubmitted: (v) {
//                if (_searchTextEditingController.text.isNotEmpty)
                  jobListViewModel.search(
                      _searchTextEditingController
                          .text);

              },
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
//                  if (_searchTextEditingController.text.isNotEmpty)
                    jobListViewModel.search(
                        _searchTextEditingController
                            .text);

                },
              ),
              controller: _searchTextEditingController,
              hintText: StringUtils.searchText,
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              children: [
                if (jobListViewModel.totalJobCount != 0)
                  if (_searchTextEditingController
                      .text.isNotEmpty &&
                      !jobListViewModel.isFetchingData)
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0),
                      child: Text(
                          '${jobListViewModel.totalJobCount} ${StringUtils.jobsFoundText}'),
                    )
              ],
            ),
          ),
        ],
      );
      var jobListWidget = ListView.builder(
          padding:
          EdgeInsets.symmetric(vertical: 4),
          physics:
          NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: jobList.length + 1,
          itemBuilder: (context, index) {
            if (index == jobList.length) {
              return jobListViewModel
                  .isFetchingMoreData
                  ? Padding(
                  padding:
                  EdgeInsets.all(15),
                  child: Loader())
                  : SizedBox();
            }

            JobListModel job = jobList[index];

            return JobListTileWidget(
              job,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            JobDetails(
                              slug: job.slug,
                              fromJobListScreenType:
                              JobListScreenType
                                  .main,
                            )));
              },
              onFavorite: () {
                jobListViewModel.addToFavorite(
                    job.jobId, index);
              },
              onApply: job.isApplied
                  ? null
                  : () {
                _showApplyForJobDialog(
                    job, index);
              },
            );
          });


      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(StringUtils.jobsText),
          actions: isMainList
              ? [
                  IconButton(
                    icon: Icon(isInSearchMode ? Icons.close : Icons.search),
                    onPressed: () {
                      _searchTextEditingController?.clear();
                      jobListViewModel.toggleIsInSearchMode();

                      if (jobListViewModel.isInSearchMode) {
                        _searchFieldFocusNode.requestFocus();
                      } else {
                        _searchFieldFocusNode.unfocus();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {
                      _scaffoldKey.currentState.openEndDrawer();
                    },
                  )
                ]
              : null,
        ),
        drawer: AppDrawer(
          routeName: 'job_list',
        ),
        endDrawer: isMainList
            ? Drawer(
                child: JobListFilterWidget(),
              )
            : null,
        body: RefreshIndicator(
          onRefresh: () async {
            _searchTextEditingController?.clear();
            Provider.of<JobListFilterWidgetViewModel>(context, listen: false)
                .resetState();
            return Provider.of<JobListViewModel>(context, listen: false)
                .refresh();
          },
          child: jobListViewModel.shouldShowPageLoader
              ? Center(child: Loader())
              : Container(
                  child: jobListViewModel.shouldShowAppError
                      ? ListView(
                          children: [errorWidget()],
                        )
                      : Column(
                          children: [
                            if (jobListViewModel.isInSearchMode)
                              searchInputWidget,
                            if (jobListViewModel.isFilterApplied)
                              FilterPreviewWidget(),
                            Expanded(
                              child: ListView(
                                physics: AlwaysScrollableScrollPhysics(),
                                controller: _scrollController,
                                children: [
                                  // loader for search and filter
                                  if (jobListViewModel.shouldSearchNFilterLoader)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Loader(),
                                    ),

                                  (jobListViewModel.jobList.length == 0 &&
                                          !jobListViewModel.isFetchingData)
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                Text(StringUtils.noJobsFound),
                                          ),
                                        )
                                      : jobListWidget,
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
        ),
      );
    });
  }

  _showApplyForJobDialog(JobListModel jobModel, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return CommonPromptDialog(
            titleText: StringUtils.doYouWantToApplyText,
            onCancel: () {
              Navigator.pop(context);
            },
            onAccept: () {
              Provider.of<JobListViewModel>(context, listen: false)
                  .applyForJob(jobModel.jobId, index);
              Navigator.pop(context);
            },
          );
        });
  }
}

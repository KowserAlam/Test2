import 'package:after_layout/after_layout.dart';
import 'package:p7app/features/assessment/models/candidate_exam_model.dart';
import 'package:p7app/features/assessment/providers/exam_provider.dart';
import 'package:p7app/features/assessment/views/time_out_screen.dart';
import 'package:p7app/features/enrolled_exam_list_screen/models/enrolled_exam_model.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:p7app/main_app/util/comon_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ExamClockBarWidget extends StatefulWidget {
  final EnrolledExamModel enrolledExamModel;
  final int questionLength;
  final Function timeOutCallBack;

  ExamClockBarWidget(
      {@required this.enrolledExamModel,
      @required this.questionLength,
      @required this.timeOutCallBack});

  @override
  _ExamClockBarWidgetState createState() => _ExamClockBarWidgetState();
}

class _ExamClockBarWidgetState extends State<ExamClockBarWidget>
    with AfterLayoutMixin {
  Duration examDuration;

  @override
  void initState() {
    examDuration = widget.enrolledExamModel.examDurationMinutes;
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
//    Duration duration = widget.enrolledExamModel.examDurationMinutes;
//    Provider.of<ExamProvider>(context).startExamClock(duration);
  }

  Widget build(BuildContext context) {
    bool isLarge = MediaQuery.of(context).size.width > 960;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        color: Theme.of(context).backgroundColor,
        child: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                  child: Text(
                    isLarge ? StringUtils.elapsedTimeText : "T : ",
                    style: kTimerTextStyleBold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
                  child: StreamBuilder<Duration>(
                      stream:
                          Provider.of<ExamProvider>(context).elapsedTimeStream,
                      builder: (context, snapshot) {

                        if (snapshot.hasData) {

                          /// Handle Time out here
                          if (snapshot.data >= examDuration) {
                            Future.delayed(Duration.zero).then((_) {
                              widget.timeOutCallBack();
                            });
                          }

                          return Text(
                            "${(snapshot.data).inHours}"
                            ":${((snapshot.data).inMinutes % 60).toString().padLeft(2, "0")}"
                            ":${((snapshot.data).inSeconds % 60).toString().padLeft(2, "0")}",
                            style: kTimerTextStyleRegular,
                          );
                        }
                        return Text(
                          "0:00:00",
                          style: kTimerTextStyleRegular,
                        );
                      }),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    isLarge
                        ? "${StringUtils.questionNoTextUpperCase}.: "
                        : "Q.N. : ",
                    style: kTimerTextStyleBold,
                    textAlign: TextAlign.center,
                  ),
                  Consumer<ExamProvider>(builder: (context, examProvider, c) {
                    return Text(
                      "${examProvider.currentQuestionIndex + 1}/${widget.questionLength}",
                      style: kTimerTextStyleRegular,
                      textAlign: TextAlign.center,
                    );
                  }),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                  child: Text(
                    "${isLarge ? StringUtils.remainingTimeText : "R "}: ",
                    style: kTimerTextStyleBold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
                  child: StreamBuilder<Duration>(
                      stream:
                          Provider.of<ExamProvider>(context).elapsedTimeStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var time = examDuration - snapshot.data + Duration(seconds: 1);
                          return Text(
                            snapshot.hasData
                                ? "${time.inHours}:${(time.inMinutes % 60).toString().padLeft(2, "0")}:${(time.inSeconds % 60).toString().padLeft(2, "0")}"
                                : "0:00:00",
                            style: kTimerTextStyleRegular,
                          );
                        }
                        return Text(
                          "0:00:00",
                          style: kTimerTextStyleRegular,
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//class ExamClockBarWidgetO extends StatefulWidget {
//  final CandidateExamModel candidateModel;
//  final questionLength;
//
//  ExamClockBarWidgetO(
//      {@required this.candidateModel, @required this.questionLength});
//
//  @override
//  _ExamClockBarWidgetStateO createState() =>
//      _ExamClockBarWidgetStateO(this.candidateModel, this.questionLength);
//}
//
//class _ExamClockBarWidgetStateO extends State<ExamClockBarWidgetO>
//    with TickerProviderStateMixin {
//  final CandidateExamModel candidateModel;
//  final int questionLength;
//
//  _ExamClockBarWidgetStateO(this.candidateModel, this.questionLength);
//
//  Animation animation;
//  AnimationController animationController;
//  Color backgroundColor;
//  Color color;
//  Duration totalDuration;
//  Duration _start;
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//
//  @override
//  void initState() {
//    color = Colors.grey;
//    totalDuration =
//        Duration(minutes: int.parse(candidateModel.durationInMinutes));
//    if (clockBloc.currentTime != null) {
//      _start = clockBloc.currentTime;
//    } else {
//      _start = Duration(minutes: int.parse(candidateModel.durationInMinutes));
////      _start = Duration(seconds: 30);
//      clockBloc.currentTime = _start;
//    }
//
////    startTimer();
//    super.initState();
//  }
//
//  _handleTimeOut() {
//    Navigator.of(context).pushReplacement(CupertinoPageRoute(
//        builder: (context) => TimeOutScreen(candidateModel)));
//  }
//
//  String getTimeString() {
//    Duration duration =
//        animationController.duration * animationController.value;
//
//    return "${duration.inHours}:${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, "0")}";
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    bool isLarge = MediaQuery.of(context).size.width > 720;
//    var examProvider = Provider.of<ExamProvider>(context);
//    return Countdown(
//      duration: clockBloc.currentTime,
//      onFinish: () {
//        _handleTimeOut();
//      },
//      builder: (context, remainingTime) {
//        clockBloc.currentTime = remainingTime;
//
//        return Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 8),
//          child: Material(
//            color: Theme.of(context).scaffoldBackgroundColor,
//            child: Row(
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
//                      child: Text(
//                        isLarge ? StringsEn.elapsedTimeText : "T : ",
//                        style: kTimerTextStyleBold,
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
//                      child: Text(
//                        "${(totalDuration - clockBloc.currentTime).inHours}:${((totalDuration - clockBloc.currentTime).inMinutes % 60).toString().padLeft(2, "0")}:${((totalDuration - clockBloc.currentTime).inSeconds % 60).toString().padLeft(2, "0")}",
//                        style: kTimerTextStyleRegular,
//                      ),
//                    ),
//                  ],
//                ),
//                Expanded(
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Text(
//                        isLarge
//                            ? "${StringsEn.questionNoTextUpperCase}.: "
//                            : "Q.N. : ",
//                        style: kTimerTextStyleBold,
//                        textAlign: TextAlign.center,
//                      ),
//                      Text(
//                        "${examProvider.currentQuestionIndex + 1}/$questionLength",
//                        style: kTimerTextStyleRegular,
//                        textAlign: TextAlign.center,
//                      ),
//                    ],
//                  ),
//                ),
//                Row(
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
//                      child: Text(
//                        "${isLarge ? StringsEn.remainingTimeText : "R "}: ",
//                        style: kTimerTextStyleBold,
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
//                      child: Text(
//                        "${remainingTime.inHours}:${(remainingTime.inMinutes % 60).toString().padLeft(2, "0")}:${(remainingTime.inSeconds % 60).toString().padLeft(2, "0")}",
//                        style: kTimerTextStyleRegular,
//                      ),
//                    ),
//                  ],
//                ),
//              ],
//            ),
//          ),
//        );
//      },
//    );
//  }
//}
//
//class ClockBloc {
//  Duration _timeTime;
//
//  Duration get currentTime => _timeTime;
//
//  set currentTime(Duration value) {
//    _timeTime = value;
//  }
//}
//
//ClockBloc clockBloc = ClockBloc();

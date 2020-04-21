import 'package:skill_check/features/assessment/models/candidate_exam_model.dart';
import 'package:skill_check/features/enrolled_exam_list_screen/models/enrolled_exam_model.dart';
import 'package:skill_check/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:skill_check/features/home_screen/views/widgets/exam_duration_widget.dart';
import 'package:skill_check/main_app/util/cosnt_style.dart';
import 'package:skill_check/main_app/util/strings_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CandidateExamInfoWidget extends StatelessWidget {
  final EnrolledExamModel enrolledExamModel;

  const CandidateExamInfoWidget({Key key, @required this.enrolledExamModel})
      : assert(enrolledExamModel != null);

  @override
  Widget build(BuildContext context) {
    bool isTabLayout = MediaQuery.of(context).size.width > 720;
    return !isTabLayout
        ? Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _buildCandidateName(),
                      _buildExamName(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildExamCode(context),
                      _buildDuration(),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 5, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildCandidateName(),
                      _buildExamName(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildCandidateID(),
                      _buildExamCode(context),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildRegistration(),
                      _buildDuration(),
                    ],
                  ),
                )
              ],
            ));
  }

  Widget _buildRegistration() {
    return Row(
      children: <Widget>[
        Text(
          "${StringUtils.regNoText}: ",
          style: kCandidateInfoTextBoldStyle,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "${enrolledExamModel.skillId}",
          style: kCandidateInfoTextStyle,
        ),
      ],
    );
  }

  Widget _buildDuration() {
    return Row(
      children: <Widget>[
        Text(
          "${StringUtils.durationText}: ",
          style: kCandidateInfoTextBoldStyle,
        ),
        Text(
          (enrolledExamModel.examDurationMinutes < Duration(minutes: 60))
              ? "${(enrolledExamModel.examDurationMinutes.inMinutes).toString().padLeft(2, "0")} min"
              : "${enrolledExamModel.examDurationMinutes.inHours} h"
                  " ${(enrolledExamModel.examDurationMinutes.inMinutes % 60).toString().padLeft(2, "0")} min",
          style: kCandidateInfoTextStyle,
        ),
      ],
    );
  }

  Widget _buildCandidateID() {
    return Consumer<DashboardScreenProvider>(
        builder: (context, dashboardScreenProvider, c) {
      return Row(
        children: <Widget>[
          Text(
            "${StringUtils.idTextUpperCase}: ",
            style: kCandidateInfoTextBoldStyle,
          ),
          Text(
            "${dashboardScreenProvider.dashBoardData.user.skillId}",
            style: kCandidateInfoTextStyle,
          ),
        ],
      );
    });
  }

  Row _buildExamCode(BuildContext context) {
    bool isLarge = MediaQuery.of(context).size.width > 720;
    return Row(
      children: <Widget>[
        Text(
          "${isLarge ? StringUtils.examCodeText : StringUtils.codeText}: ",
          style: kCandidateInfoTextBoldStyle,
        ),
        Expanded(
          child: Text(
            enrolledExamModel.examCode,
            style: kCandidateInfoTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildCandidateName() {
    return Consumer<DashboardScreenProvider>(
        builder: (context, dashboardScreenProvider, c) {
      return Row(
        children: <Widget>[
          Text(
            "${StringUtils.nameText}: ",
            style: kCandidateInfoTextBoldStyle,
          ),
          Expanded(
            child: Text(
              dashboardScreenProvider.dashBoardData.user.name,
              style: kCandidateInfoTextStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildExamName() {
    return Row(
      children: <Widget>[
        Text(
          "${StringUtils.examText}: ",
          style: kCandidateInfoTextBoldStyle,
        ),
        Expanded(
          child: Text(
            enrolledExamModel.examName,
            style: kCandidateInfoTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

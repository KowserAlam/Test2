
import 'package:p7app/features/assessment/models/candidate_exam_model.dart';
import 'package:p7app/features/assessment/views/instruction_screen.dart';
import 'package:p7app/features/enrolled_exam_list_screen/models/enrolled_exam_model.dart';
import 'package:p7app/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:p7app/features/home_screen/views/widgets/exam_duration_widget.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:p7app/main_app/util/cosnt_style.dart';
import 'package:p7app/main_app/widgets/circular_icon_button_primary_color.dart';
import 'package:p7app/main_app/widgets/gredient_buton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProceedScreen extends StatefulWidget {
  final EnrolledExamModel enrolledExamModel;

  ProceedScreen({@required this.enrolledExamModel}):assert(enrolledExamModel != null);

  @override
  _ProceedScreenState createState() => _ProceedScreenState(this.enrolledExamModel);
}

class _ProceedScreenState extends State<ProceedScreen> {
  final EnrolledExamModel enrolledExamModel;

  _ProceedScreenState(this.enrolledExamModel);

  @override
  Widget build(BuildContext context) {
    bool isTabLayout = MediaQuery.of(context).size.width > 720;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: Text(StringUtils.textExamInfo),
      ),
      body:
          isTabLayout ? _buildTabLayout(context) : _buildMobileLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildTabLayout(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10),
                  Consumer<DashboardScreenProvider>(
                    builder: (context, dashboardScreenProvider,c) {
                      return Text(
                        "Candidate: ${dashboardScreenProvider.dashBoardData.user.name}",
                        style: kTitleTextBlackStyle,
                      );
                    }
                  ),

                  SizedBox(height: 10),
                  Text(
                    "Exam: ${enrolledExamModel.examName}",
                    style: kTitleTextBlackStyle,
                  ),
                  SizedBox(height: 10),
                  ExamDurationWidget(duration: enrolledExamModel.examDurationMinutes,textStyle: kTitleTextBlackStyle,),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
//          _buildButtons(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GradientButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              label: StringUtils.cancelButtonText,
            ),
            GradientButton(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ExamInstructionScreen(
                              enrolledExamModel: enrolledExamModel,
                            )));
              },
              label: StringUtils.proceedButtonText,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 8,
        ),
      ],
    );
  }
}

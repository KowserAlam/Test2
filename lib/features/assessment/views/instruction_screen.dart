import 'package:p7app/features/assessment/views/widgets/candidate_examinfo_widget.dart';
import 'package:p7app/features/enrolled_exam_list_screen/models/enrolled_exam_model.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:p7app/main_app/app_theme/comon_styles.dart';
import 'package:p7app/main_app/widgets/circular_icon_button_primary_color.dart';
import 'package:p7app/main_app/widgets/gredient_buton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'exam_screen.dart';
import '../models/candidate_exam_model.dart';

class ExamInstructionScreen extends StatelessWidget {
  final EnrolledExamModel enrolledExamModel;

  ExamInstructionScreen({@required this.enrolledExamModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).backgroundColor,
        child: Container(
          height: 60,
          child: Center(
            child: GradientButton(
              label: StringUtils.startExamText,
              onTap: () {
                _handleStartExam(context);
              },
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(StringUtils.instructionText),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CandidateExamInfoWidget(
                enrolledExamModel: enrolledExamModel,
              ),
              SizedBox(height: 5),
              Divider(),
              buildTextInstruction(context),
              SizedBox(height: 5),
              buildInstructionWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextInstruction(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Text(
        StringUtils.instructionText,
        style: Theme.of(context)
            .textTheme
            .display1
            .apply(color: Theme.of(context).primaryColor),
      ),
    );
  }

  Widget buildInstructionWidget() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Html(
            data: enrolledExamModel.instruction ?? "",
            defaultTextStyle: TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }

  Widget buildTextExamName() {
    return Text(
      "${StringUtils.examText}: ${enrolledExamModel.examName}",
      style: kTitleTextBlackStyle,
    );
  }

  void _handleStartExam(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ExamScreen(
                  enrolledExamModel: enrolledExamModel,
                )));
  }
}

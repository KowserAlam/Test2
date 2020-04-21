import 'package:after_layout/after_layout.dart';
import 'package:skill_check/features/assessment/providers/exam_provider.dart';
import 'package:skill_check/features/assessment/providers/submit_provider.dart';
import 'package:skill_check/features/enrolled_exam_list_screen/models/enrolled_exam_model.dart';
import 'package:skill_check/main_app/util/strings_utils.dart';
import '../models/candidate_exam_model.dart';
import '../models/questions_model.dart';
import 'package:skill_check/features/assessment/views/result_screen.dart';
import 'package:skill_check/main_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeOutScreen extends StatefulWidget {
  final EnrolledExamModel enrolledExamModel;

  TimeOutScreen(this.enrolledExamModel);

  @override
  _TimeOutScreenState createState() => _TimeOutScreenState();
}

class _TimeOutScreenState extends State<TimeOutScreen> with AfterLayoutMixin {
  bool isRetrying = false;

  @override
  void afterFirstLayout(BuildContext context) {
    submitAns(context);
  }

  submitAns(BuildContext context) async {
    var submitProvider = Provider.of<SubmitProvider>(context,listen: false);
    var questionList = Provider.of<ExamProvider>(context,listen: false).questionList;
    bool isSuccessful = await submitProvider.handleSubmit(
        context, "${widget.enrolledExamModel.profSkillId}");

    if (isSuccessful) {
      Future.delayed(Duration(seconds: 3)).then((_) {
        isRetrying = false;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ResultScreen()));
      });
    } else {
      setState(() {
        isRetrying = true;
      });
      Future.delayed(Duration(seconds: 3)).then((_) {
        submitAns(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.timer_off, size: 80, color: Colors.red[700]),
          //Time out Icon
          SizedBox(
            height: 30,
          ),
          Text(
            "Time Out",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.red[700]),
          ),
          SizedBox(
            height: 20,
          ),

          Text(
            StringUtils.yourProgressIsSubmitting,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          isRetrying
              ? Text(
            StringUtils.failedToSubmit,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 18),
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          Loader(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

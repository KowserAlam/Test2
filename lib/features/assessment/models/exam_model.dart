

import 'package:assessment_ishraak/features/assessment/models/questions_model.dart';

class ExamModel {
  List<QuestionModel> questionListWithAns;

  ExamModel({this.questionListWithAns});

  ExamModel.fromJson(Map<String, dynamic> json) {
    if (json['questionListWithAns'] != null) {
      questionListWithAns = new List<QuestionModel>();
      json['questionListWithAns'].forEach((v) {
        questionListWithAns.add(new QuestionModel.fromJson(v));
      });
    }
  }

}

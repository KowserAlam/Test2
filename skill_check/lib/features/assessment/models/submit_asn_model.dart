import 'package:skill_check/main_app/util/json_keys.dart';
import 'package:flutter/cupertino.dart';

class SubmitAnsModel {
  String examId;
  String userId;
  List<SubmitQuestionAnsModel> questionAnsList;

  SubmitAnsModel({
    @required this.examId,
    @required this.questionAnsList,
    @required this.userId,
  });

  SubmitAnsModel.fromJson(Map<String, dynamic> json) {
    examId = json[JsonKeys.examId];
    userId = json[JsonKeys.professionalId];
    if (json[JsonKeys.questionAnsList] != null) {
      questionAnsList = new List<SubmitQuestionAnsModel>();
      json[JsonKeys.questionAnsList].forEach((v) {
        questionAnsList.add(new SubmitQuestionAnsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[JsonKeys.examId] = this.examId;
    data[JsonKeys.professionalId] = this.userId;
    if (this.questionAnsList != null) {
      data[JsonKeys.questionAnsList] =
          this.questionAnsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubmitQuestionAnsModel {
  String questionText;
  String questionIdId;
  String submittedAnsId;

  SubmitQuestionAnsModel(
      {this.questionText, this.questionIdId, this.submittedAnsId});

  SubmitQuestionAnsModel.fromJson(Map<String, dynamic> json) {
    questionText = json['question_text'];
    questionIdId = json['question_id_id'];
    submittedAnsId = json['submitted_ans_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_text'] = this.questionText;
    data['question_id_id'] = this.questionIdId;
    data['submitted_ans_id'] = this.submittedAnsId;
    return data;
  }
}

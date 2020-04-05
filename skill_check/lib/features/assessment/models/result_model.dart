class ResultModel {
  int numberOfQuestion;
  int correctAns;
  double percentageOfRightAns;

  ResultModel({this.numberOfQuestion, this.correctAns, this.percentageOfRightAns});

  ResultModel.fromJson(Map<String, dynamic> json) {
    numberOfQuestion = json['number_of_question'];
    correctAns = json['correct_ans'];
    percentageOfRightAns = double.parse(json['percentage_of_right_ans'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number_of_question'] = this.numberOfQuestion;
    data['correct_ans'] = this.correctAns;
    data['percentage_of_right_ans'] = this.percentageOfRightAns;
    return data;
  }
}
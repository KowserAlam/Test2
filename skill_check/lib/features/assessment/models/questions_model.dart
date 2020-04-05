class QuestionModel {
  String id = "";
  String question = "";
  List<Answers> options = [];
  bool isMarkedForReview = false;
  List<Answers> selectedAnswers = [];
  int questionNumber;
  String questionType = "Checkbox";

  QuestionModel(
      {this.id, this.question, this.options, this.isMarkedForReview,
    this.selectedAnswers,this.questionNumber}
    );



  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    question = json['question'];

    if(json['qtype'] != null) {
      questionType = json['qtype']["name"] ??"";
    }

    if (json['answers'] != null) {
      options = new List<Answers>();
      json['answers'].forEach((v) {
        options.add(new Answers.fromJson(v));

      });
    }
  }

  @override
  String toString() {
    return 'QuestionModel{id: $id, question: $question, options: $options, isConfused: $isMarkedForReview, correctAnswers: $selectedAnswers}';
  }


}



class Answers {
  String id;
  String name;
  bool correct;

  Answers({this.id, this.name, this.correct});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    return '$id';
  }


}

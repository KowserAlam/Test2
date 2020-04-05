import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class QuestionTextWidget extends StatelessWidget {
  final String question;
  final int questionNumber;

  const QuestionTextWidget({
    @required this.question,
    @required this.questionNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Html(
      defaultTextStyle: TextStyle(fontSize: 22),
      data: getQuestionText(),
      useRichText: true,
      showImages: true,
    );
  }

  getQuestionText() {
    if (question.substring(0, 3) == "<p>") {
      return "<p> <b>$questionNumber. </b> ${question.substring(3)}";
    }

    return "<b>$questionNumber. </b> $question";
  }
}

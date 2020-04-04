import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:flutter/material.dart';

class QuestionNumberWidget extends StatelessWidget {
  final totalQuestionCount;
  final index;
  final bool isConfused;
  final Function onPressedOnCheckBox;

  QuestionNumberWidget(
      {this.totalQuestionCount,
        this.index,
        this.isConfused,
        this.onPressedOnCheckBox});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            "${StringUtils.questionTextUpperCase} ${index + 1}/$totalQuestionCount",
            style:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
          ),
        ),
        Text(
          StringUtils.confusedText,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isConfused ? Colors.yellow[900] : Colors.grey),
        ),
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.yellow[900]),
          child: Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: Colors.yellow[900],
            onChanged: onPressedOnCheckBox,
            value: isConfused,
          ),
        ),
      ],
    );
  }
}
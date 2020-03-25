import 'package:p7app/features/assessment/models/questions_model.dart';
import 'package:flutter/material.dart';

class QuestionReviewIndicatorItemWidget extends StatefulWidget {
  final List<QuestionModel> questionModelList;
  final Function onPressed;

  QuestionReviewIndicatorItemWidget(
      {@required this.questionModelList, @required this.onPressed});

  @override
  _QuestionReviewIndicatorItemWidgetState createState() =>
      _QuestionReviewIndicatorItemWidgetState(this.questionModelList, this.onPressed);
}

class _QuestionReviewIndicatorItemWidgetState extends State<QuestionReviewIndicatorItemWidget> {
  final Function onPressed;
  final List<QuestionModel> questionModelList;

  _QuestionReviewIndicatorItemWidgetState(this.questionModelList, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          itemCount: questionModelList.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (context, index) {
            Color color = Colors.grey[600];

            if (questionModelList[index].selectedAnswers != null) {
              if (questionModelList[index].selectedAnswers.length > 0) {
                color = Colors.green[700];
              }
            }
            if (questionModelList[index].isMarkedForReview ?? false) {
              color = Colors.yellow[800];
            }
            return InkWell(
              onTap: onPressed,
              child: GridTile(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: color,
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 21),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

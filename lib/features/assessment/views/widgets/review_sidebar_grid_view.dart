import 'package:p7app/features/assessment/models/questions_model.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReviewSideBarGridView extends StatefulWidget {
  final List<QuestionModel> questionList;
  final int selectedTabIndex;
  final Function onTap;
  final bool isMarkedOrMissedOnly;

  ReviewSideBarGridView(
      {@required this.questionList,
        @required this.selectedTabIndex,
        @required this.onTap,
        this.isMarkedOrMissedOnly});

  @override
  _ReviewSideBarGridViewState createState() => _ReviewSideBarGridViewState();
}

class _ReviewSideBarGridViewState extends State<ReviewSideBarGridView> {
  ScrollController _scrollController;

  @override // NEW
  void initState() {
    // NEW
    super.initState(); // NEW
    _scrollController = new ScrollController(
      // NEW
      initialScrollOffset: 0.0, // NEW
      keepScrollOffset: true, // NEW
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.questionList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          if (widget.questionList[index].questionNumber == null) {
            widget.questionList[index].questionNumber = index;
          }
          Color color = AppTheme.notAttemptedColor;
          bool isAttempted = false;
          bool isMarkedForReview = false;

          if (widget.questionList[index].selectedAnswers != null) {
            if (widget.questionList[index].selectedAnswers.length > 0) {
              color = AppTheme.attemptedColor;
              isAttempted = true;
            }
          }
          if (widget.questionList[index].isMarkedForReview ?? false) {
            isMarkedForReview = true;
          }
          bool isSelected = widget.selectedTabIndex == index;
          return InkWell(
            onTap: () {
              widget.onTap(index);
            },
            child: Padding(
              padding: EdgeInsets.all(isSelected ? 0 : 3.0),
              child: Container(
               decoration: BoxDecoration(
                 boxShadow:isSelected ? [BoxShadow(color: Colors.black54,blurRadius: 5)]:null,
                 borderRadius: BorderRadius.circular(50),
                 color:
                 isMarkedForReview ? AppTheme.markedForReviewColor : color,
               ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    backgroundColor: color,
                    child: Text(
                      (widget.questionList[index].questionNumber + 1)
                          .toString(),
                      style: TextStyle(
                          color:
                          isSelected ? Colors.yellowAccent : Colors.white,
                          fontWeight:
                          isSelected ? FontWeight.w900 : FontWeight.w500,
                          fontSize: isSelected ? 23 : 21),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

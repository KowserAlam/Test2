import 'package:skill_check/main_app/util/cosnt_style.dart';
import 'package:skill_check/main_app/util/strings_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MarkForReviewButtonWidget extends StatelessWidget {
  final Function onTap;
  final bool isMarkedForReview;

  MarkForReviewButtonWidget({@required this.onTap,this.isMarkedForReview,});

  @override
  Widget build(BuildContext context) {
    bool isTabLayout = MediaQuery.of(context).size.width>720;
    return InkWell(
      onTap: onTap,
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 4, right: 8),
            child: isMarkedForReview
                ? Icon(
              FontAwesomeIcons
                  .solidCheckSquare,
              color: Theme.of(context)
                  .primaryColor,
            )
                : Icon(
              FontAwesomeIcons.square,
              color: Colors.grey,
            ),
          ),
          isTabLayout
              ? Padding(
            padding: const EdgeInsets.only(
                top: 4),
            child: Text(
              StringUtils.markedForReviewText,
              style: kTitleTextBlackStyle,
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}

import 'package:p7app/features/featured_exam_screen/views/featured_exams_screen.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewMoreButtonWidget extends StatelessWidget {
  final Function onTap;

  ViewMoreButtonWidget({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
        child: Text(
          StringUtils.viewMoreText,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .title
              .apply(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

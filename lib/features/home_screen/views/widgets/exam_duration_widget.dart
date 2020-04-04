import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:flutter/material.dart';

class ExamDurationWidget extends StatelessWidget {
  final Duration duration;
  final TextStyle textStyle;

  ExamDurationWidget({@required this.duration, this.textStyle});

  @override
  Widget build(BuildContext context) {
    if (duration < Duration(minutes: 60)) {
      return Text(
        "${StringUtils.durationText}:  ${(duration.inMinutes).toString().padLeft(2, "0")} minute",
        style: textStyle,
      );
    }
    return Text(
      "${StringUtils.durationText}: ${duration.inHours} hour"
      " ${(duration.inMinutes % 60).toString().padLeft(2, "0")} min",
      style: textStyle,
    );
  }
}

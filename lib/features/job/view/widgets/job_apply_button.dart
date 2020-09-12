import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/method_extension.dart';

class JobApplyButton extends StatelessWidget {
  final Function onPressedApply;
  final DateTime applicationDeadline;
  final bool isApplied;

  const JobApplyButton({
    @required this.onPressedApply,
    @required this.applicationDeadline,
    @required this.isApplied,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDateExpired = applicationDeadline != null
        ? (applicationDeadline.isBefore(DateTime.now()) &&
            !applicationDeadline.isToday())
        : false;

    bool isAppliedDisabled = isApplied || isDateExpired;
    var buttonColor = Theme.of(context).primaryColor;
    var textColor = Colors.black;

    if (isApplied) {
      buttonColor = Colors.blue[200];
      textColor = Colors.white;
    } else {
      if (isDateExpired) {
        buttonColor = Colors.grey;
        textColor = Colors.white;
      }
    }
    return Tooltip(
      message: "Apply Button",
      child: Material(
        elevation: 4,
        color: buttonColor,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: isAppliedDisabled ? () {} : onPressedApply,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 30,
            width: 80,
            alignment: Alignment.center,
         // padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),

            child: Text(
              "${isApplied
                  ? StringResources.appliedText
                  : StringResources.applyText}",
              key: Key('applyButtonText'),
              style: TextStyle(
                  fontSize: 15, color: textColor, ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

class JobApplyButton extends StatelessWidget {
  final Function onPressedApply;
  final DateTime applicationDeadline;
  final bool isApplied ;
  const JobApplyButton({
    @required this.onPressedApply,
    @required this.applicationDeadline,
    @required this.isApplied,
  });

  @override
  Widget build(BuildContext context) {
    bool isAppliedDisabled = isApplied;

    bool isDateExpired = applicationDeadline != null
        ? DateTime.now().isAfter(applicationDeadline)
        : true;

    return  Material(
      color: isApplied
          ? Colors.blue[200]
          : (isDateExpired ? Colors.grey : Theme.of(context).accentColor),
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: isAppliedDisabled
            ? null
            : onPressedApply,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 30,
          width: 65,
          alignment: Alignment.center,
//          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),

          child: Text(
            isApplied ? StringUtils.appliedText : StringUtils.applyText,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }


}

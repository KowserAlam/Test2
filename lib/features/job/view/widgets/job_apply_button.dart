import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/method_extension.dart';

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



    bool isDateExpired = applicationDeadline != null
        ? (applicationDeadline.isBefore(DateTime.now()) && !applicationDeadline.isToday() )
        : false;
    bool isAppliedDisabled = isApplied || isDateExpired;
    return  Material(
      color: isApplied
          ? Colors.blue[200]
          : (isDateExpired ? Colors.grey : Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: isAppliedDisabled
            ? (){}
            : onPressedApply,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 30,
          width: 65,
          alignment: Alignment.center,
//          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),

          child: Text(
            isApplied ? StringResources.appliedText : StringResources.applyText,
            style: TextStyle(
                fontSize: 15, color: isDateExpired?Colors.white:Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }


}

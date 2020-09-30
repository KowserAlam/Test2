import 'package:flutter/material.dart';
import 'package:p7app/features/job/view/widgets/apply_now_modal_widget.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/custom_zefyr_rich_text_from_field.dart';
import 'package:p7app/method_extension.dart';

class JobApplyButton extends StatelessWidget {
  final Function onSuccessfulApply;
  final DateTime applicationDeadline;
  final bool isApplied;
  final String jobId;
  final String jobTitle;


  const JobApplyButton({
    @required this.onSuccessfulApply,
    @required this.applicationDeadline,
    @required this.isApplied,
    @required this.jobTitle,
    @required this.jobId,
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
          onTap:(){
            if(!isAppliedDisabled){
              _showApplyDialog(context);
            }
          },
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

  _showApplyDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return ApplyNowModalWidget(jobTitle,jobId,onSuccessfulApply);
        });
  }
}

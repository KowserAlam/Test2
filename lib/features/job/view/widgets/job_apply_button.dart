import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:p7app/features/auth/view/sign_in_screen.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/features/job/view/widgets/apply_now_modal_widget.dart';
import 'package:p7app/features/settings/view_models/web_settings_view_model.dart';
import 'package:p7app/main_app/auth_service/auth_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/common_prompt_dialog.dart';
import 'package:p7app/main_app/views/widgets/custom_zefyr_rich_text_from_field.dart';
import 'package:p7app/method_extension.dart';
import 'package:provider/provider.dart';

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
    bool isLoggerIn = Provider.of<AuthViewModel>(context).isLoggerIn;

    bool isDateExpired = applicationDeadline != null
        ? (applicationDeadline.isBefore(DateTime.now()) &&
            !applicationDeadline.isToday())
        : false;

    bool isAppliedDisabled = isApplied || isDateExpired;
    var buttonColor = Theme.of(context).primaryColor;
    var textColor = Colors.black;

    if (isApplied) {
      buttonColor = Colors.white;
      textColor = Colors.black;
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
          
      
             if(!isLoggerIn){
               _showLoginDialog(context);
             }else{
               if(!isAppliedDisabled){
                 var profileCompletePercent = Provider.of<DashboardViewModel>(context,listen: false).profileCompletePercent;
                 var minimumProfileCompleteness =  Get.find<WebSettingsViewModel>().settings.value?.minimumProfileCompleteness??60;
                 if( profileCompletePercent >= minimumProfileCompleteness){
                   _showApplyDialog(context);
                 }else{
                   _showInCompleteProfileMessageDialog(context);
                 }
                
               }
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

  _showLoginDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return CommonPromptDialog(
            titleText: StringResources.signInRequiredText,
            content: Text(StringResources.doYouWantToSingInNowText),
            onCancel: () {
              Navigator.pop(context);
            },
            onAccept: () {

              Navigator.pop(context);
              Get.to(SignInScreen());
              // Navigator.of(context).push(
              //     CupertinoPageRoute(builder: (context) => SignInScreen()));
            },
          );
        });
  }
  _showInCompleteProfileMessageDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Icon(FontAwesomeIcons.timesCircle,size: 40,color: Color(0xfff27474),),
            content: Text(StringResources.pleaseCompleteYourProfile,textAlign: TextAlign.center,),
            actions: [

              RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                  child: Text("OK"),
                  onPressed: (){
                    Get.back();
                  }),
            ],
          );
        });
  }
  _showApplyDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return ApplyNowModalWidget(jobTitle,jobId,onSuccessfulApply);
        });
  }
}

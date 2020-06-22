import 'package:flutter/material.dart';
import 'package:p7app/features/auth/view_models/password_reset_view_model.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/common_button.dart';
import 'package:provider/provider.dart';

class PasswordRestLinkSuccessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(StringUtils.aPasswordRestLinkHasBeenSentToText),
      SizedBox(height: 10,),
      Consumer<PasswordResetViewModel>(
        builder: (context,passwordResetViewModel,_) {
          return Text(passwordResetViewModel.email??"",style: TextStyle(fontWeight: FontWeight.bold),);
        }
      ),
        SizedBox(height: 10,),
        CommonButton(label: StringUtils.backText,onTap: (){Navigator.pop(context);},),
      ],
    ),);
  }
}

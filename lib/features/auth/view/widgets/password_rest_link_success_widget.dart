import 'package:flutter/material.dart';
import 'package:p7app/features/auth/provider/password_reset_provider.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:provider/provider.dart';

class PasswordRestLinkSuccessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(StringUtils.aPasswordRestLinkHasBeenSentToText),
      Consumer<PasswordResetViewModel>(
        builder: (context,passwordResetViewModel,_) {
          return Text(passwordResetViewModel.email??"");
        }
      )
      ],
    ),);
  }
}

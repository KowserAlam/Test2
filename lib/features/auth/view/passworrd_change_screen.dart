import 'package:flutter/material.dart';
import 'package:p7app/features/auth/view/widgets/custom_text_field_rounded.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/common_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _currentPasswordTextController, _newPasswordTextController, _confirmPasswordTextController;

  @override
  Widget build(BuildContext context) {
    var currentPassword = CustomTextFieldRounded(
      controller: _currentPasswordTextController,
      labelText: StringUtils.currentPasswordText,
    );
    var newPassword = CustomTextFieldRounded(
      labelText: StringUtils.newPasswordText,
      controller: _newPasswordTextController,
    );
    var confirmPassword = CustomTextFieldRounded(
      controller: _confirmPasswordTextController,
      labelText: StringUtils.confirmNewPasswordText,
    );
    var submitButton = Container(
      height: 50,
      width: 200,
      child: CommonButton(
        onTap: (){

        },
        label: StringUtils.submitButtonText,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            currentPassword,
            SizedBox(height: 15,),
            newPassword,
            SizedBox(height: 15,),
            confirmPassword,
            SizedBox(height: 20,),
            submitButton
          ],
        ),
      ),
    );
  }
}

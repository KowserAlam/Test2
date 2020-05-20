import 'package:flutter/material.dart';
import 'package:p7app/features/auth/provider/password_change_view_model.dart';
import 'package:p7app/features/auth/view/widgets/custom_text_field_rounded.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/common_button.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _currentPasswordTextController,
      _newPasswordTextController,
      _confirmPasswordTextController;

  bool validate() {
    return _currentPasswordTextController != null &&
        _newPasswordTextController != null &&
        _confirmPasswordTextController != null;
  }

  @override
  Widget build(BuildContext context) {
    var changePassViewModel = Provider.of<PasswordChangeViewModel>(context);

    var oldPassword = CustomTextFieldRounded(
      errorText: changePassViewModel.errorTextOldPassword,
      onChanged: (val) {
        changePassViewModel.onChangeOldPassword(val);
      },
      controller: _currentPasswordTextController,
      labelText: StringUtils.currentPasswordText,
    );
    var newPassword = CustomTextFieldRounded(
      errorText: changePassViewModel.errorTextNewPassword,
      onChanged: (val) {
        changePassViewModel.onChangeNewPassword(val);
      },
      labelText: StringUtils.newPasswordText,
      controller: _newPasswordTextController,
    );
    var confirmPassword = CustomTextFieldRounded(
      errorText: changePassViewModel.errorTextConfirmPassword,
      onChanged: (val) {
        changePassViewModel.onChangeConfirmPassword(val);
      },
      controller: _confirmPasswordTextController,
      labelText: StringUtils.confirmNewPasswordText,
    );
    var submitButton = Container(
      height: 50,
      width: 200,
      child: CommonButton(
        onTap: changePassViewModel.allowSubmitButton
            ? changePassViewModel.changePassword
            : null,
        label: StringUtils.submitButtonText,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.changePasswordAppbarText),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            oldPassword,
            SizedBox(
              height: 15,
            ),
            newPassword,
            SizedBox(
              height: 15,
            ),
            confirmPassword,
            SizedBox(
              height: 20,
            ),
            submitButton
          ],
        ),
      ),
    );
  }
}

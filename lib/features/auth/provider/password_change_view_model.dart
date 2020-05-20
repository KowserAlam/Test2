import 'package:flutter/cupertino.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';

class PasswordChangeViewModel with ChangeNotifier {

  String _errorTextOldPassword;
  String _errorTextNewPassword;
  String _errorTextConfirmPassword;


  String get errorTextOldPassword => _errorTextOldPassword;

  set errorTextOldPassword(String value) {
    _errorTextOldPassword = value;
  }


  String get errorTextNewPassword => _errorTextNewPassword;

  set errorTextNewPassword(String value) {
    _errorTextNewPassword = value;
  }

  String get errorTextConfirmPassword => _errorTextConfirmPassword;

  set errorTextConfirmPassword(String value) {
    _errorTextConfirmPassword = value;
  }

  changePassword(
      {@required String oldPassword, @required String newPassword}) {

    ApiClient().postRequest(Urls.passwordChangeUrl, {

    });
  }
}

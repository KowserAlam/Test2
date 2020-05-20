import 'dart:convert';
import 'dart:io';
import 'package:p7app/main_app/util/method_extension.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';

class PasswordChangeViewModel with ChangeNotifier {
  String _oldPassword = "";
  String _newPassword = "";
  String _confirmNewPassword = "";

  String _errorTextOldPassword;
  String _errorTextNewPassword;
  String _errorTextConfirmPassword;
  bool _isBusy = false;

  bool get isBusy => _isBusy;

  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

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

  bool get allowSubmitButton {
    bool isNoErrors = _errorTextConfirmPassword == null &&
        _errorTextNewPassword == null &&
        _errorTextOldPassword == null;

    bool isNoEmptyFields = _newPassword.isNotEmptyOrNotNull &&
        _oldPassword.isNotEmptyOrNotNull &&
        _confirmNewPassword.isNotEmptyOrNotNull;

    return isNoEmptyFields & isNoErrors;
  }

  bool validate() {
    onChangeOldPassword(_oldPassword);
    onChangeNewPassword(_newPassword);
    onChangeConfirmPassword(_confirmNewPassword);

    return _errorTextNewPassword == null &&
        _errorTextConfirmPassword == null &&
        _errorTextOldPassword == null;
  }

  onChangeOldPassword(String val) {
    _oldPassword = val;
    _errorTextOldPassword = Validator().validateEmptyPassword(val);
    notifyListeners();
  }

  onChangeNewPassword(String val) {
    _newPassword = val;
    _errorTextNewPassword = Validator().validatePassword(val);

    if(_confirmNewPassword.isNotEmptyOrNotNull){
      onChangeConfirmPassword(_confirmNewPassword);
    }
    notifyListeners();
  }

  onChangeConfirmPassword(String val) {
    _confirmNewPassword = val;
    _errorTextConfirmPassword =
        Validator().validateConfirmPassword(_newPassword, val);

    notifyListeners();
  }

  Future<bool> changePassword() async {
    bool isValid = validate();
    print(isValid);

    if (isValid) {
      isBusy = true;
      var userId = await AuthService.getInstance()
          .then((value) => value.getUser().userId);
      var body = {
        "user_id": userId,
        "old_password": _oldPassword,
        "new_password": _newPassword
      };

      try {
        var res = await ApiClient().postRequest(Urls.passwordChangeUrl, body);

        print(res.statusCode);
        print(res.body);
        isBusy = false;
//        var data = json.decode(res.body);
//        if(data['status'] == "success"){
//
//        }
        if (res.statusCode == 200) {
          return true;
        } else {
          var data = json.decode(res.body);
          var message = data['message'];
          _errorTextOldPassword = message;
          notifyListeners();
          return false;
        }
      } on SocketException catch (e) {
        isBusy = false;
        print(e);
        BotToast.showText(text: StringUtils.checkInternetConnectionMessage);
        return false;
      } catch (e) {
        isBusy = false;
        print(e);
        BotToast.showText(text: StringUtils.somethingIsWrong);
        return false;
      }
    } else {
      print('invalid');
      return false;
    }
  }
}

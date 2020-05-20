import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
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



  onChangeOldPassword(String val) {
    _oldPassword = val;
  }

  onChangeNewPassword(String val) {
    _newPassword = val;
    _newPassword =  Validator().validatePassword(val);
    notifyListeners();
  }
  onChangeConfirmPassword(String val) {
    _confirmNewPassword = val;
    _errorTextConfirmPassword =
        Validator().validateConfirmPassword(_oldPassword, val);

    notifyListeners();
  }

  Future<bool> changePassword(
      {@required String oldPassword, @required String newPassword}) async{
    isBusy = true;

    try{
      var res = await ApiClient().postRequest(Urls.passwordChangeUrl, {});
      isBusy = false;
      if(res.statusCode ==200){
        return true;

      }else{
        return false;
      }

    }
    on SocketException catch (e){
      isBusy = false;
      print(e);
      BotToast.showText(text: StringUtils.checkInternetConnectionMessage);
      return false;
    }
    catch (e){
      isBusy = false;
      print(e);
      BotToast.showText(text: StringUtils.somethingIsWrong);
      return false;
    }

  }
}

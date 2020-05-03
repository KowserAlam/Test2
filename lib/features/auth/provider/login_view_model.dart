import 'dart:convert';
import 'dart:io';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/auth_service/auth_user_model.dart';
import 'package:p7app/features/auth/models/login_signup_response_model.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:http/http.dart' as http;
import 'package:p7app/main_app/resource/json_keys.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel with ChangeNotifier {
  bool _isObscurePassword = true;
  String _email = "";
  String _password = "";
  bool _isBusyLogin = false;
  bool _isFromSuccessfulSignUp = false;
  String _errorTextEmail;
  String _errorTextPassword;
  String _errorMessage;


  String get errorMessage => _errorMessage;

  String get errorTextEmail => _errorTextEmail;

  set errorTextEmail(String value) {
    _errorTextEmail = value;
  }

  String get errorTextPassword => _errorTextPassword;

  set errorTextPassword(String value) {
    _errorTextPassword = value;
  }

  bool get isFromSuccessfulSignUp => _isFromSuccessfulSignUp;

  set isFromSuccessfulSignUp(bool value) {
    _isFromSuccessfulSignUp = value;
    notifyListeners();
  }

  bool get isObscurePassword => _isObscurePassword;

  set isObscurePassword(bool value) {
    _isObscurePassword = value;
    notifyListeners();
  }

  bool get isBusyLogin => _isBusyLogin;

  set isBusyLogin(bool value) {
    _isBusyLogin = value;
    notifyListeners();
  }

  String get password => _password;

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  clearMessage(){
    _errorMessage = null;
    notifyListeners();
  }

   bool validate(){
    validateEmailLocal(_email);
    validatePasswordLocal(_password);
    return errorTextEmail == null && errorTextPassword == null;

  }
  validateEmailLocal(String val) {
    errorTextEmail = Validator().validateEmail(val?.trim());
    _email = val;
    _errorMessage = null;
    notifyListeners();
  }

  validatePasswordLocal(String val) {
    errorTextPassword = Validator().validateEmptyPassword(val);
    _password = val?.trim();
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> loginWithEmailAndPassword() async {
    isBusyLogin = true;
    var body = {
      JsonKeys.email: email,
      JsonKeys.password: password,
    };

    try {
      http.Response response = await ApiClient().postRequest(Urls.loginUrl, body);

      print(response.body);
      print(response.statusCode);

      isBusyLogin = false;
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedJson = jsonDecode(response.body);
        _saveAuthData(decodedJson);
        clearMessage();
        return true;
      } else {
        var decodedJson = jsonDecode(response.body);
        var m = decodedJson['detail']?.toString() ?? "";
        _errorMessage = m;
        notifyListeners();
        BotToast.showText(text: m);
        return false;
      }
    } on SocketException catch (e) {
      isBusyLogin = false;
      BotToast.showText(text: StringUtils.checkInternetConnectionMessage);
      _errorMessage = StringUtils.checkInternetConnectionMessage;
      notifyListeners();
      print(e);
      return false;
    } catch (e) {
      print(e);
      isBusyLogin = false;
      BotToast.showText(text: StringUtils.somethingIsWrong);
      return false;
    }
  }

  resetState() {
    _isObscurePassword = true;
    _email = "";
    _password = "";
    _isBusyLogin = false;
    _isFromSuccessfulSignUp = false;
    _errorTextEmail = null;
    _errorTextEmail = null;
    _errorMessage = null;

  }

  _saveAuthData(Map<String, dynamic> data) async {
    AuthUserModel.fromJson(data);
    var auth = await AuthService.getInstance();
    return auth.saveUser(data);
  }

  signOut() async {
    var prf = await SharedPreferences.getInstance();
    prf.remove(JsonKeys.user);
  }


}

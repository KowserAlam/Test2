import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:p7app/features/auth/models/login_signup_response_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/resource/json_keys.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class SignUpViewModel with ChangeNotifier {
  bool _isObscurePassword;
  bool _isObscureConfirmPassword;
  bool _isBusy = false;
  String _errorTextEmail;
  String _errorTextPassword;
  String _errorTextMobile;
  String _message;
  String _email = "";
  String _password = "";

  String _errorText = "";

  //Email getter setter validation
  set errorTextEmail(String value) {
    _errorTextEmail = value;
  }
  String get errorTextEmail => _errorTextEmail;

  validateEmailLocal(String val) {
    errorTextEmail = Validator().validateEmail(val?.trim());
    _email = val;
    _message = null;
    notifyListeners();
  }

  //Password getter setter validation
  String get errorTextPassword => _errorTextPassword;

  set errorTextPassword(String value) {
    _errorTextPassword = value;
  }

  validatePasswordLocal(String val) {
    errorTextPassword = Validator().validatePassword(val);
    _password = val?.trim();
    _message = null;
    notifyListeners();
  }

  //Mobile getter setter validation
  String get errorTextMobile => _errorTextMobile;

  set errorTextMobile(String value) {
    _errorTextMobile = value;
  }

  validateMobileLocal(String val) {
    errorTextPassword = Validator().nullFieldValidate(val);
    _password = val?.trim();
    _message = null;
    notifyListeners();
  }

  bool get isObscurePassword => _isObscurePassword ?? true;

  set isObscurePassword(bool value) {
    _isObscurePassword = value;
    notifyListeners();
  }

  bool get isObscureConfirmPassword => _isObscureConfirmPassword ?? true;

  set isObscureConfirmPassword(bool value) {
    _isObscureConfirmPassword = value;
    notifyListeners();
  }

  bool get isBusy => _isBusy;

  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  Future<bool> signUpWithEmailPassword(
      {String name, String email, String password, String mobile}) async {
    var body = {
      "full_name": name,
      "email": email,
      "phone": mobile,
      "password": password,
      "confirm_password": password,
      "terms_and_condition_status": "on"
    };

    try{

      BotToast.showLoading();
      http.Response res = await ApiClient().postRequest(Urls.signUpUrl, body);
      print(res.statusCode);

      if(res.statusCode == 200){
        BotToast.showText(text: 'Sign up successful');
        BotToast.closeAllLoading();
        return true;
      }else{
        BotToast.closeAllLoading();
        BotToast.showText(text: "Unable to complete sign up");
        return false;
      }

    }catch (e){
      BotToast.closeAllLoading();
      BotToast.showText(text: "Unable to complete sign up");
      print(e);
      return false;


    }

  }
}

/// performing user input validations
final performEmailValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) async {
  String result = Validator().validateEmail(email);
  if (result == null) {
    sink.add(email);
  } else {
    sink.addError(result);
  }
});

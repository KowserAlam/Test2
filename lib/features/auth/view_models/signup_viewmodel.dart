import 'dart:async';
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/util/validator.dart';

class SignUpViewModel with ChangeNotifier {
  bool _isObscurePassword;
  bool _isObscureConfirmPassword;
  bool _isFromSuccessfulSignUp = false;
  bool _isBusy = false;
  String _errorTextEmail;
  String _errorTextPassword;
  String _errorTextMobile;
  String _errorTextName;
  String _errorTextConfirmPassword;
  String _message;
  String _email = "";
  String _mobile = "";
  String _name = "";
  String _password = "";
  //String _confirmPassword = "";

  String _errorText = "";

  bool get isFromSuccessfulSignUp => _isFromSuccessfulSignUp;

  set isFromSuccessfulSignUp(bool value) {
    _isFromSuccessfulSignUp = value;
    notifyListeners();
  }

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

  //Confirm Password getter setter validation
  String get errorTextConfirmPassword => _errorTextConfirmPassword;

  set errorTextConfirmPassword(String value) {
    _errorTextConfirmPassword = value;
  }

//  validateConfirmPasswordLocal(String val) {
//    errorTextConfirmPassword = Validator().validateConfirmPassword(_password, val);
//    _confirmPassword = val?.trim();
//    _message = null;
//    notifyListeners();
//  }

  //Mobile getter setter validation
  String get errorTextMobile => _errorTextMobile;

  set errorTextMobile(String value) {
    _errorTextMobile = value;
  }

  validateMobileLocal(String val) {
    errorTextMobile = Validator().validatePhoneNumber(val);
    _mobile = val?.trim();
    _message = null;
    notifyListeners();
  }

  //Name getter setter validation
  String get errorTextName => _errorTextName;

  set errorTextName(String value) {
    _errorTextName = value;
  }

  validateNameLocal(String val) {
    errorTextName = Validator().nullFieldValidate(val);
    _name = val?.trim();
    _message = null;
    notifyListeners();
  }

  //Validate
  bool validate(){
    validateEmailLocal(_email);
    validatePasswordLocal(_password);
    //validateConfirmPasswordLocal(_confirmPassword);
    validateMobileLocal(_mobile);
    validateNameLocal(_name);
    return errorTextEmail == null && errorTextPassword == null && errorTextConfirmPassword == null && errorTextName== null && errorTextMobile == null;

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
      print(res.body);

      var decodedJson = json.decode(res.body);
      if(decodedJson["status"] == "success"){
        BotToast.showText(text: 'Sign up successful');
        BotToast.closeAllLoading();
        return true;
      }else{
        BotToast.closeAllLoading();
        BotToast.showText(text: "${decodedJson["message"]}");
        return false;
      }

    }catch (e){
      BotToast.closeAllLoading();
      BotToast.showText(text: "Unable to complete sign up");
      print(e);
      return false;


    }

  }

  resetState() {
    _isObscurePassword = true;
    _isObscureConfirmPassword = true;
    _email = "";
    _password = "";
    _confirmPassword = "";
    _name = "";
    _mobile = "";
    _isBusy = false;
    _isFromSuccessfulSignUp = false;
    _errorTextEmail = null;
    _errorTextPassword = null;
    _errorTextConfirmPassword = null;
    _errorTextMobile = null;
    _errorTextName = null;
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

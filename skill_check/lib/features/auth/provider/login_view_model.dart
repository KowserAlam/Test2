import 'dart:convert';
import 'dart:io';
import 'package:skill_check/main_app/api_helpers/api_client.dart';
import 'package:skill_check/main_app/auth_service/auth_service.dart';
import 'package:skill_check/main_app/auth_service/auth_user_model.dart';
import 'package:skill_check/features/auth/models/login_signup_response_model.dart';
import 'package:skill_check/main_app/api_helpers/urls.dart';
import 'package:skill_check/main_app/util/strings_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:http/http.dart' as http;
import 'package:skill_check/main_app/util/json_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel with ChangeNotifier {
  bool _isObscurePassword = true;
  String _email = "";
  String _password = "";
  bool _isBusyLogin = false;
  bool _isFromSuccessfulSignUp = false;

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
        return true;
      } else {
        var decodedJson = jsonDecode(response.body);
        var message = decodedJson['detail'] ?? "";
        BotToast.showText(text: message);
        return false;
      }
    } on SocketException catch (e) {
      isBusyLogin = false;
      print(e);
      return false;
    } catch (e) {
      print(e);
      isBusyLogin = false;
      return false;
    }
  }

  resetState() {
    isObscurePassword = true;
    email = "";
    password = "";
    isBusyLogin = false;
    isFromSuccessfulSignUp = false;
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

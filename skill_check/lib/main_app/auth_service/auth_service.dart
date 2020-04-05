import 'dart:convert';

import 'package:skill_check/main_app/auth_service/auth_user_model.dart';
import 'package:skill_check/main_app/util/json_keys.dart';
import 'package:skill_check/main_app/util/local_storage.dart';
import 'package:skill_check/main_app/util/strings_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static AuthService _instance;
  static LocalStorageService _localStorageService;

  static Future<AuthService> getInstance() async {
    if (_instance == null) {
      _instance = AuthService();
    }
    if (_localStorageService == null) {
      _localStorageService = await LocalStorageService.getInstance();
    }
    return _instance;
  }

  AuthUserModel getUser() {
    var userMap = _localStorageService.getString(JsonKeys.user);
    if (userMap == null) {
      return null;
    }
    return AuthUserModel.fromJson(json.decode(userMap));
  }

  Future<bool> saveUser(Map<String,dynamic> data){
    var encodedData = json.encode(data);
    return _localStorageService.saveString(JsonKeys.user,encodedData);

  }

  Future<bool> checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null)
      return true;
    else
      return false;
  }
}

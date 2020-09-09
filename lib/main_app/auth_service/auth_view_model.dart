import 'package:flutter/material.dart';
import 'package:p7app/main_app/auth_service/auth_user_model.dart';

class AuthViewModel with ChangeNotifier {
  AuthUserModel _user;

  bool get isLoggerIn => user?.accessToken != null && user?.userId != null;

  AuthUserModel get user => _user;

  set user(AuthUserModel value) {
    if (user != value) {
      _user = value;
      notifyListeners();
    }
  }
}

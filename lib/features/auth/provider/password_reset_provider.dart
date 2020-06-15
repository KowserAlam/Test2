import 'dart:async';
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:p7app/main_app/util/method_extension.dart';

class PasswordResetViewModel with ChangeNotifier {
  bool _isBusyEmail = false;
  bool _isBusyVerifyCode = false;
  bool _isBusyNewPassword = false;
  String _emailErrorText;
  bool _isCodeResend = false;
  bool _isValidCode = true;
  bool _isObscureConfirmPassword = true;
  bool _isObscurePassword = true;
  bool _isBusyConfirmation = false;
  bool _passwordResetMethodIsEmail = true;
  String _email;

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get emailErrorText => _emailErrorText;

  set emailErrorText(String value) {
    _emailErrorText = value;
  }

  bool get passwordResetMethodIsEmail => _passwordResetMethodIsEmail;

  set passwordResetMethodIsEmail(bool value) {
    _passwordResetMethodIsEmail = value;
    notifyListeners();
  }

  bool get isObscureConfirmPassword => _isObscureConfirmPassword;

  set isObscureConfirmPassword(bool value) {
    _isObscureConfirmPassword = value;
    notifyListeners();
  }

  bool get isValidCode => _isValidCode;

  set isValidCode(bool value) {
    _isValidCode = value;
  }

  bool get isCodeResend => _isCodeResend;

  set isCodeResend(bool value) {
    _isCodeResend = value;
    notifyListeners();
  }

  bool get isBusyEmail => _isBusyEmail;

  set isBusyEmail(bool value) {
    _isBusyEmail = value;
    notifyListeners();
  }

  bool get isBusyVerifyCode => _isBusyVerifyCode;

  set isBusyVerifyCode(bool value) {
    _isBusyVerifyCode = value;
    notifyListeners();
  }

  bool get isBusyNewPassword => _isBusyNewPassword;

  set isBusyNewPassword(bool value) {
    _isBusyNewPassword = value;
    notifyListeners();
  }

  bool get isObscurePassword => _isObscurePassword;

  set isObscurePassword(bool value) {
    _isObscurePassword = value;
    notifyListeners();
  }

  bool get isBusyConfirmation => _isBusyConfirmation;

  set isBusyConfirmation(bool value) {
    _isBusyConfirmation = value;
    notifyListeners();
  }

  bool validateEmailLocal(String email) {
    emailErrorText = Validator().validateEmail(email);
    _email = email;
    notifyListeners();
    return _emailErrorText == null;
  }

  Future<bool> sendResetPasswordLink({ApiClient apiClient}) async {
    if (validateEmailLocal(_email)) {
      var client = apiClient ?? ApiClient();
      isBusyEmail = true;
      var url = Urls.passwordResetUrl;
      var body = {"email": _email};

      try {
        http.Response res = await client.postRequest(url, body);
        print(res.statusCode);
        print(res.body);
        if (res.statusCode == 200) {
          isBusyEmail = false;
          return true;
        } else {
          var data = json.decode(res.body);
          _emailErrorText =
              data['email']?.toString() ?? StringUtils.somethingIsWrong;
          isBusyEmail = false;
          return false;
        }
      } catch (e) {
        isBusyEmail = false;
        print(e);

//      BotToast.showText(text: null);
        return false;
      }
    } else {
      return false;
    }
  }
  bool get shodAllowProceedButton => _emailErrorText == null && _email.isNotEmptyOrNotNull;
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
final performPhoneValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) async {
  String result = Validator().validatePhoneNumber(value);
  if (result == null) {
    sink.add(value);
  } else {
    sink.addError(result);
  }
});

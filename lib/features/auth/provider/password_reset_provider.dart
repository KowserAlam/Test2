import 'dart:async';

import 'package:assessment_ishraak/main_app/util/validator.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';


class PasswordResetProvider with ChangeNotifier{

  bool _isBusyEmail = false;
  bool _isBusyVerifyCode = false;
  bool _isBusyNewPassword = false;
  String _emailErrorText = "";

  var _inputStream = PublishSubject<String>();
  bool _isCodeResend = false;
  bool _isValidCode = true;
  bool _isObscureConfirmPassword = true;
  bool _isObscurePassword = true;
  bool _isBusyConfirmation = false;
  bool _passwordResetMethodIsEmail = true;


  bool get passwordResetMethodIsEmail => _passwordResetMethodIsEmail;

  set passwordResetMethodIsEmail(bool value) {
    _passwordResetMethodIsEmail = value;
    notifyListeners();
    _inputStream.addError("");
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

  /// Handle SignUp Email Stream
  Stream<String> get inputStream =>
      _inputStream.stream.transform(_passwordResetMethodIsEmail?performEmailValidation:performPhoneValidation);

  Function(String) get inputSink => _inputStream.sink.add;

  String get emailErrorText => _emailErrorText ?? null;



  @override
  void dispose() {
    _inputStream.close();
    super.dispose();
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
final performPhoneValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) async {
      String result = Validator().validatePhoneNumber(value);
      if (result == null) {
        sink.add(value);
      } else {
        sink.addError(result);
      }
    });

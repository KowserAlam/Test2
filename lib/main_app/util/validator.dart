import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/method_extension.dart';

class Validator {
  String nullFieldValidate(String value) =>
      value.isEmptyOrNull ? StringUtils.thisFieldIsRequired : null;

  String validateEmailG(String email) =>
      !email.contains("@") ? StringUtils.invalidEmail : null;

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (value.isEmpty) {
      return StringUtils.pleaseEnterEmailText;
    }else if (!regex.hasMatch(value))
      return StringUtils.pleaseEnterAValidEmailText;
    else
      return null;
  }

  String validatePassword(String value) {
    final RegExp _passwordRegExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
    );
    if (value.isEmpty) {
      return StringUtils.thisFieldIsRequired;
    } else if (!_passwordRegExp.hasMatch(value)) {
      return StringUtils.passwordMustBeEight;
    } else {
      return null;
    }
  }

  String validateEmptyPassword(String value) {
    if (value.isEmpty) {
      return StringUtils.pleaseEnterPasswordText;
    }  else {
      return null;
    }
  }

  String validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return StringUtils.passwordDoesNotMatch;
    } else {
      return null;
    }
  }

  String validatePhoneNumber(String value) {
//    Pattern pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    Pattern pattern = r'\+?(88)?0?1[56789][0-9]{8}\b';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return StringUtils.enterValidPhoneNumber;
    else
      return null;
  }

  String verificationCodeValidator(String value) {
    Pattern pattern = r'^(\d{6})?$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return StringUtils.invalidCode;
    else
      return null;
  }

  String expertiseFieldValidate(String value){
    double x;
    Pattern pattern = r'^([0-9]{1,2})+(\.[0-9]{1,2})?$';
    RegExp regex = new RegExp(pattern);
    if(value.isEmpty){
      return StringUtils.thisFieldIsRequired;
    }else {
      if(!regex.hasMatch(value)){
        return StringUtils.twoDecimal;
      }else{
        x = double.parse(value);
        if(x >=0 && x <11){
          return null;
        }else{
          return StringUtils.valueWithinRange;
        }
      }
    }
  }

}

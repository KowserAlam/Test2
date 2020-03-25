

import 'package:assessment_ishraak/main_app/util/strings_utils.dart';

class Validator{
  String nullFieldValidate(String value)=> value.isEmpty? StringUtils.thisFieldIsRequired : null;
   String validateEmailG(String email) =>
      !email.contains("@") ? StringUtils.invalidEmail : null;



  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return StringUtils.invalidEmail;
    else
      return null;
  }

  String validatePassword(String value){
    final RegExp _passwordRegExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
    );

    if(!_passwordRegExp.hasMatch(value)){
      return StringUtils.passwordMustBeEight;
    } else{
      return null;
    }
  }


  String validateConfirmPassword(String password, String confirmPassword){

    if(password != confirmPassword){
      return StringUtils.passwordDoesNotMatch;
    } else{
      return null;
    }
  }


  String validatePhoneNumber(String value) {
    Pattern pattern =
        r'^[+]*[s\./0-9]*$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return StringUtils.enterValidPhoneNumber;
    else
      return null;
  }


  String verificationCodeValidator(String value) {
    Pattern pattern =
        r'^(\d{6})?$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return StringUtils.invalidCode;
    else
      return null;
  }
}



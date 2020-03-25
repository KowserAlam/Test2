


import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:flutter_test/flutter_test.dart';

main() {

  test("Verification Code Validator Testing with less then 6 digit , Should return invalid code",(){

    String actual = Validator().verificationCodeValidator(54654.toString());

    expect(actual, StringUtils.invalidCode);

  });

  test("Verification Code Validator Testing with more then 6 digit , Should return invalid code",(){

    String actual = Validator().verificationCodeValidator(5465454454.toString());

    expect(actual, StringUtils.invalidCode);

  });


  test("Verification Code Validator Testing with charecter , Should return invalid code",(){

    String actual = Validator().verificationCodeValidator("dsefca");

    expect(actual, StringUtils.invalidCode);

  });

  test("Verification Code Validator Testing with 6 digit, Should return null",(){

    String actual = Validator().verificationCodeValidator(546546.toString());

    expect(actual, null);

  });



}
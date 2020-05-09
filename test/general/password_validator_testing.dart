

import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test("Invalid password Testing, Should return Invalid Password",(){

    Validator validator = Validator();

    var actual = validator.validatePassword("?=*");
    expect(actual, StringUtils.passwordMustBeEight);

  });


  test("Valid password Testing, Should return null",(){

    Validator validator = Validator();

    var actual = validator.validatePassword("password123");
    expect(actual, null);

  });


  test("Invalid password Testing with white space, Should return Invalid Password",(){

    Validator validator = Validator();

    var actual = validator.validatePassword("passw ord123");
    expect(actual, StringUtils.passwordMustBeEight);

  });


  test("Invalid password Testing with white space, Should return Invalid Password",(){

    Validator validator = Validator();

    var actual = validator.validatePassword("1234 1678q");
    expect(actual, StringUtils.passwordMustBeEight);

  });
}
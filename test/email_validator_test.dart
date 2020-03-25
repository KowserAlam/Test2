

import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:test/test.dart';

main(){


  test("Valid Email Testing, Should return null",(){

    Validator validator = Validator();

    var actual = validator.validateEmail("shofi@ishraak.com");
    expect(actual, null);

  });

  test("Invalid Email Testing, Should return Invalid Email",(){

    Validator validator = Validator();

    var actual = validator.validateEmail("shofiishraak.com");
    expect(actual, StringUtils.invalidEmail);

  });

  test("Empty Email Testing, Should return Invalid Email",(){

    Validator validator = Validator();

    var actual = validator.validateEmail("");
    expect(actual, StringUtils.invalidEmail);

  });

  test("Invalid Email Testing, Should return Invalid Email",(){

    Validator validator = Validator();

    var actual = validator.validateEmail("sfsdffsdf@");
    expect(actual, StringUtils.invalidEmail);

  });

  test("Invalid Email Testing with white space, Should return Invalid Email",(){

    Validator validator = Validator();

    var actual = validator.validateEmail("sfsdffsd f@");
    expect(actual, StringUtils.invalidEmail);

  });

}


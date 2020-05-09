import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:test/test.dart';

main(){


  test("Valid Email Testing, Should return null",(){

    Validator validator = Validator();

    var actual = validator.validateEmail("shofi@ishraak.com");
    expect(actual, null);

  });

  test("Invalid Email Testing, Should return pleaseEnterAValidEmailText",(){

    Validator validator = Validator();

    var actual = validator.validateEmail("shofiishraak.com");
    expect(actual, StringUtils.pleaseEnterAValidEmailText);

  });

  test("Empty Email Testing, Should return ${StringUtils.pleaseEnterEmailText}",(){

    Validator validator = Validator();

    var actual = validator.validateEmail("");
    expect(actual, StringUtils.pleaseEnterEmailText);

  });

  test("Invalid Email Testing, Should return ${StringUtils.pleaseEnterAValidEmailText}",(){

    Validator validator = Validator();

    var actual = validator.validateEmail("sfsdffsdf@");
    expect(actual, StringUtils.pleaseEnterAValidEmailText);

  });

  test("Invalid Email Testing with white space, Should return ${StringUtils.pleaseEnterAValidEmailText}",(){

    Validator validator = Validator();

    var actual = validator.validateEmail("sfsdffsd f@");
    expect(actual, StringUtils.pleaseEnterAValidEmailText);

  });

}


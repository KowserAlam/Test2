import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';

main(){
  test("Valid Rating Testing, Should return null",(){

    Validator validator = Validator();

    var actual = validator.expertiseFieldValidate("10");
    expect(actual, null);
  });

  test("More than two decimal points, Should return Please enter a value within 0-9 and with two decimal values max",(){

    Validator validator = Validator();

    var actual = validator.expertiseFieldValidate("10.999");
    expect(actual, StringUtils.twoDecimal);
  });


  test("Value greater than 10 input, Should return Please enter a value within 0-10",(){

    Validator validator = Validator();

    var actual = validator.expertiseFieldValidate("16.66");
    expect(actual, StringUtils.valueWithinRange);
  });

  test("Value lesser than 0 input, Should return Please enter a value within 0-9 and with two decimal values max",(){

    Validator validator = Validator();

    var actual = validator.expertiseFieldValidate("-9");
    expect(actual, StringUtils.twoDecimal);
  });


}
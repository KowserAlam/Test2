

import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:assessment_ishraak/main_app/util/validator.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test("Null Field Validator Testing with empty string, Should return this field is requird",(){

   String actual = Validator().nullFieldValidate("");

   expect(actual, StringUtils.thisFieldIsRequired);

  });


  test("Null Field Validator Testing with non empty string, Should return null",(){

    String actual = Validator().nullFieldValidate("this is non empty string");

    expect(actual,null);

  });
}
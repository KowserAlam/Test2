

import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test("Null Field Validator Testing with empty string, Should return this field is requird",(){

   String actual = Validator().nullFieldValidate("");

   expect(actual, StringResources.thisFieldIsRequired);

  });

  test("Null Field Validator Testing with null string, Should return this field is requird",(){

    String actual = Validator().nullFieldValidate(null);

    expect(actual, StringResources.thisFieldIsRequired);

  });


  test("Null Field Validator Testing with non empty string, Should return null",(){
    String actual = Validator().nullFieldValidate("this is non empty string");
    expect(actual,null);
  });




}
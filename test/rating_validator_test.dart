import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/main_app/util/validator.dart';

main(){
  test("Valid Rating Testing, Should return null",(){

    Validator validator = Validator();

    var actual = validator.validateEmail("12");
    expect(actual, null);

  });
}
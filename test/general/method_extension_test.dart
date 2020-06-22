import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/method_extension.dart';

main(){


  group("StringExtensionTest,isEmptyOrNullTest",(){

    test("isEmptyOrNullTest, should return true", (){
      var re = StringExtension("").isEmptyOrNull;
      expect(re, true);
    });
    test("isEmptyOrNullTest, should return true", (){
      var re = StringExtension(null).isEmptyOrNull;
      expect(re, true);
    });

    test("isEmptyOrNullTest,should return false", (){
      var re = StringExtension("hi").isEmptyOrNull;
      expect(re, false);
    });
  });

  group("StringExtensionTest,isNotEmptyOrNullTest",(){

    test("isNotEmptyOrNullTest, should return true", (){
      var re = StringExtension("").isNotEmptyOrNotNull;
      expect(re, false);
    });
    test("isNotEmptyOrNullTest, should return true", (){
      var re = StringExtension(null).isNotEmptyOrNotNull;
      expect(re, false);
    });

    test("isNotEmptyOrNullTest,should return false", (){
      var re = StringExtension("hi").isNotEmptyOrNotNull;
      expect(re, true);
    });
  });

}
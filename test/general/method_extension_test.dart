import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/main_app/util/method_extension.dart';

main(){


  group("StringExtensionTest,isEmptyOrNullTest",(){

    test("isEmptyOrNullTest, should return true", (){
      var re = StringExtenion("").isEmptyOrNull;
      expect(re, true);
    });
    test("isEmptyOrNullTest, should return true", (){
      var re = StringExtenion(null).isEmptyOrNull;
      expect(re, true);
    });

    test("isEmptyOrNullTest,should return false", (){
      var re = StringExtenion("hi").isEmptyOrNull;
      expect(re, false);
    });
  });

  group("StringExtensionTest,isNotEmptyOrNullTest",(){

    test("isNotEmptyOrNullTest, should return true", (){
      var re = StringExtenion("").isNotEmptyOrNotNull;
      expect(re, false);
    });
    test("isNotEmptyOrNullTest, should return true", (){
      var re = StringExtenion(null).isNotEmptyOrNotNull;
      expect(re, false);
    });

    test("isNotEmptyOrNullTest,should return false", (){
      var re = StringExtenion("hi").isNotEmptyOrNotNull;
      expect(re, true);
    });
  });

}
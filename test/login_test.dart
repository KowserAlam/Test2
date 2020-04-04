import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:p7app/main_app/util/validator.dart';


class MockClient extends Mock implements http.Client {}
  void main(){


   test("Password is small",(){
     var actual = Validator().validatePassword("1@2");
     var expected = StringUtils.passwordMustBeEight ;
     expect(actual, expected);
   });


   test("password long enough but dosen't meet recurements",(){
     var actual = Validator().validatePassword("kfjeoifngjdroslsjrierkiren");
     var expected = StringUtils.passwordMustBeEight ;
     expect(actual, expected);
   });

   test("Password is empty",(){
     var actual = Validator().validatePassword("");
     var expected = StringUtils.thisFieldIsRequired ;
     expect(actual, expected);
   });

   test("When password length is valid, should return null ",(){
     var actual = Validator().validatePassword("saiful123123");
     expect(actual, null);
   });


//   group('loginTest', () {
//     var body = json.encode({
//       "username": "",
//       "password": "",
//     });
//
//   });


  }

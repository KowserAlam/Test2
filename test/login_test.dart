
import 'package:assessment_ishraak/features/exam_center/center_login_screen.dart';
import 'package:assessment_ishraak/main_app/api_helpers/urls.dart';
import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assessment_ishraak/features/exam_center/Centerlogin_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MockClient extends Mock implements http.Client {}
  void main(){


   test("Password is small",(){
     var actual = LoginValidator.validatePassword("1@2");
     var expected = StringUtils.invalidPassword ;
     expect(actual, expected);
   });


   test("password is too large",(){
     var actual = LoginValidator.validatePassword("kfjeoifngjdroslsjrierkirenvmnaleioriswpol");
     var expected = StringUtils.invalidPassword ;
     expect(actual, expected);
   });

   test("Password is empty",(){
     var actual = LoginValidator.validatePassword("");
     var expected = StringUtils.invalidPassword ;
     expect(actual, expected);
   });

   test("When password length is valid, should return null ",(){
     var actual = LoginValidator.validatePassword("sdfsdfsdf");
     var expected;
     expect(actual, expected);
   });


   group('loginTest', () {
     var body = json.encode({
       "username": "",
       "password": "",
     });
     test('returns a data if login successful successfully', () async {

       final client = MockClient();
       CenterLoginProvider loginProvider = CenterLoginProvider();
       // Use Mockito to return a successful response when it calls the
       // provided http.Client.
       var resBodySuccess = {
         "status": "ok",
         "code": 200,
         "message": "You are successfully logged in",
         "result": {
           "user": {
             "username": "ishraak"
           }
         }
       };
//       print(resBodySuccess);


       when( client.post(Urls.loginUrl,body: body))
           .thenAnswer((_) async {
         return  http.Response(json.encode(resBodySuccess), 200,headers:  {
           'content-type': 'application/json'
         });
       });

       expect(await loginProvider.sendHttpLoginRequestToServer(client).then((val)=>json.decode(val.body)) , resBodySuccess);

     });


     test('404,should throw Exception', () async {
       final client = MockClient();
       CenterLoginProvider loginProvider = CenterLoginProvider();
       // Use Mockito to return a successful response when it calls the
       // provided http.Client.
       when(client.post(Urls.loginUrl,body: body))
           .thenAnswer((_) async => http.Response('Not Found',404,));
       expect( loginProvider.sendHttpLoginRequestToServer(client), throwsException);
     });



     test('404,should throw Exception', () async {

       var resBodyFailed = {
         "status": "failed",
         "code": 401,
         "message": "Wrong Username or Password",
         "result": {
           "user": {
             "": ""
           }
         }
       };

       final client = MockClient();
       CenterLoginProvider loginProvider = CenterLoginProvider();
       // Use Mockito to return a successful response when it calls the
       // provided http.Client.
       when(client.post(Urls.loginUrl,body: body))
           .thenAnswer((_) async => http.Response(json.encode(resBodyFailed),401,));
       expect( loginProvider.sendHttpLoginRequestToServer(client), throwsException);
     });



   });


  }

import 'dart:convert';
import 'dart:io';

import 'package:skill_check/features/auth/models/login_signup_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_data/dataReader.dart';

void main() {



  group("fromJson", () {



    //setup test data

    var tResponseUser = ResponseUser(
      email: "shofizone@gmail.com",
      userId: "9",
    );


    test("Should return a valid model when status success code 200", () async{
      var responseJsonSuccess = await TestDataReader().readData("response_model_success.json");
      /// arrange
      final Map<String, dynamic> jsonMap = json.decode(responseJsonSuccess);

      /// act
      final result = LoginSignUpResponseModel.fromJson(jsonMap);

      /// assert
      expect(result.code, 200);
    });




    test(
        "ResponseUser Test with email, Should return a "
            "valid model with user when status success",
        () async{
          var responseJsonSuccess = await TestDataReader().readData("response_model_success.json");

      /// arrange
      final Map<String, dynamic> jsonMap = json.decode(responseJsonSuccess);

      /// act
      final result = LoginSignUpResponseModel.fromJson(jsonMap);

      /// assert
      expect(result.result.user.email, tResponseUser.email);
    });

    test(
        "ResponseUser Test with id, Should return a valid model with user when status success",
            () async{
              var responseJsonSuccess = await TestDataReader().readData("response_model_success.json");

          /// arrange
          final Map<String, dynamic> jsonMap = json.decode(responseJsonSuccess);

          /// act
          final result = LoginSignUpResponseModel.fromJson(jsonMap);

          /// assert
          expect(result.result.user.userId, tResponseUser.userId);
        });





    test("Should return a valid model when status failed", ()async {

      var responseJsonFailed = await TestDataReader().readData("response_model_failed.json");
      /// arrange
      final Map<String, dynamic> jsonMap = json.decode(responseJsonFailed);

      /// act
      final result = LoginSignUpResponseModel.fromJson(jsonMap);

      /// assert
      expect(result.code, 401);
    });

  });
}

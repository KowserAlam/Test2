import 'dart:convert';

import 'package:p7app/features/user_profile/models/user_profile_models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_data/dataReader.dart';

main() {
  group("Test UserProfileModel.formJosn", () {

    var tUserName = "Shofi";
    var tUserEmail = "shofi@ishraak.com";
    var tUserCity = "Dhaka";
    var responseJsonSuccess;

    setUp(() async {
       responseJsonSuccess =
          await TestDataReader().readData("user_profile_data.json");
    });

    test(
        "UserProfileModel.fromJsonmethode test, should returen  valid name",
            () {
          /// arrange
          final Map<String, dynamic> jsonMap = json.decode(responseJsonSuccess);

          /// act
          final result = UserProfileModel.fromJson(jsonMap["data"]["user"]);


          /// assert
          expect(result.displayName, tUserName);
          expect(result.email, tUserEmail);
          expect(result.city, tUserCity);
        });


    test(
        "UserProfileModel.fromJsonmethode test, should returen nul",
            () {
          /// arrange
          final Map<String, dynamic> jsonMap = json.decode(responseJsonSuccess);

          /// act
          final result = UserProfileModel.fromJson(jsonMap["data"]);


          /// assert
          expect(result.id, null);

        });





  });
}

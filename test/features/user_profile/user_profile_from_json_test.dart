import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import '../../test_data/dataReader.dart';


main(){
  group("UserModel.fromJsonTest method test", () {
    var responseJsonSuccess;
    //arrange
    setUp(() async {
      responseJsonSuccess =
      await TestDataReader().readData("user_profile_data.json");
    });

    test("Email Test, Testing with valid json should return valid email",
            () {
          // arrange
          var data = json.decode(responseJsonSuccess);

//      print(data[JsonKeys.data][JsonKeys.enrolledExamList]);

          //act
          var model = UserModel.fromJson(data);

          //assert

          expect(model.personalInfo.email, 'shofi@ishraak.com');
        });

  });
}
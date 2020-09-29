import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/features/user_profile/repositories/institution_list_repository.dart';

import '../test_data/dataReader.dart';



main(){
  group("UserModel.fromJsonTest method test", () {
    var responseJsonSuccess;
    //arrange
    setUp(() async {
      responseJsonSuccess =
      await TestDataReader().readData("institute_list.json");
    });

    test("institute_list Test, Testing with valid json should return valid list",
            () {
          // arrange
          var data = json.decode(responseJsonSuccess);
//      print(data[JsonKeys.data][JsonKeys.enrolledExamList]);
          //act
          var list = InstitutionListRepository().fromJson(data);
          //assert
          expect(list.length, 3);
        });

  });
}
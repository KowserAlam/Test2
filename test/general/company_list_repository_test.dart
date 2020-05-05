import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:p7app/features/user_profile/repositories/company_list_repository.dart';
import 'package:p7app/features/user_profile/repositories/industry_list_repository.dart';

import '../test_data/dataReader.dart';



main(){
  group("Company List Repository test", () {
    var responseJsonSuccess;
    setUp(() async {
      responseJsonSuccess =
      await TestDataReader().readData("company_list.json");
    });

    test("industry_list Test, Testing with valid json should return valid list",
            () {
          // arrange
          var data = json.decode(responseJsonSuccess);

//      print(data[JsonKeys.data][JsonKeys.enrolledExamList]);

          //act
          var list = CompanyListRepository().fromJson(data);

          //assert

          expect(list.length, 9);
        });

  });
}
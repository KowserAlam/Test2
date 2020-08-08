import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/main_app/repositories/industry_list_repository.dart';
import '../test_data/dataReader.dart';

main(){
  group("industry_list_repository  test", () {
    var responseJsonSuccess;
    //arrange
    setUp(() async {
      responseJsonSuccess =
      await TestDataReader().readData("industry_list.json");
    });

    test("industry_list Test, Testing with valid json should return valid list",
            () {
          // arrange
          var data = json.decode(responseJsonSuccess);

//      print(data[JsonKeys.data][JsonKeys.enrolledExamList]);

          //act
          var list = IndustryListRepository().fromJson(data);

          //assert

          expect(list.length, 17);
        });

  });
}
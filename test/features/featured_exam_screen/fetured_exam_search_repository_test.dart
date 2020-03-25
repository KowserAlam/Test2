import 'dart:convert';
import 'package:assessment_ishraak/features/featured_exam_screen/models/featured_exam_model.dart';
import 'package:assessment_ishraak/features/featured_exam_screen/repositories/featured_exam_list_repository.dart';
import 'package:assessment_ishraak/features/home_screen/repositories/fetured_exam_search_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_data/dataReader.dart';

void main() {
  //setup test data
  var tListLength = 2;
  var tID = 1;

  group("Featured exam repository test", () {
    var responseJsonSuccess;
    //arrange
    setUp(() async {
      responseJsonSuccess =
      await TestDataReader().readData("fetured_exam_search_result.json");
    });

    test("jsonFromMap with valid json should return valid list",
            () {
          // arrange
          var data = json.decode(responseJsonSuccess);
          //act
          var list = FeaturedExamSearchRepository().jsonFromMap(data);
          //assert
          expect(list.length, tListLength);
        });

    test("jsonFromMap tesst with invalid josn should return empty list",
            () {
          // arrange
          var data = {};
          //act
          var list = FeaturedExamSearchRepository().jsonFromMap(data);
          //assert

          expect(list.length, 0);
        });

    test("jsonFromMap test with a valid json data, should return first's elements id",
            () {
          // arrange
              var data = json.decode(responseJsonSuccess);
          //act
          List<FeaturedExamModel> list = FeaturedExamSearchRepository().jsonFromMap(data);
          //assert

          expect(list[0].id, tID);
        });
  });
}

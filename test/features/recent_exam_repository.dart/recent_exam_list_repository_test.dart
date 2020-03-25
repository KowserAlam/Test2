import 'dart:convert';
import 'package:p7app/features/featured_exam_screen/repositories/featured_exam_list_repository.dart';
import 'package:p7app/features/recent_exam/repositories/recent_exam_list_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_data/dataReader.dart';

void main() {
  //setup test data

  group("RecentExamrepository enrollExamListFromJsonTest method test", () {
    var responseJsonSuccess;
    //arrange
    setUp(() async {
      responseJsonSuccess =
          await TestDataReader().readData("recent_exam_list_success.json");
    });

    test("enrollExamListFromJsonTest ith valid json should return valid list",
        () {
      // arrange
      var data = json.decode(responseJsonSuccess);

//      print(data[JsonKeys.data][JsonKeys.enrolledExamList]);

      //act
      var list = RecentExamListRepository().recentExamModelFromMapJson(data);

      //assert

      expect(list.length, 1);
    });

    test("enrollExamListFromJsonTest invalid josn should return empty list",
        () {
      // arrange

      var data = {};

      //act
      var list = FeaturedExamListRepository.enrolledExamModelFromMapJson(data);

      //assert

      expect(list.length, 0);
    });
  });
}

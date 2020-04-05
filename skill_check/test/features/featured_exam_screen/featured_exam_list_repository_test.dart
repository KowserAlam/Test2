import 'dart:convert';

import 'package:skill_check/features/enrolled_exam_list_screen/repositories/enroll_exam_list_repository.dart';

import 'package:skill_check/features/enrolled_exam_list_screen/repositories/self_enroll_exam_repository.dart';
import 'package:skill_check/features/featured_exam_screen/repositories/featured_exam_list_repository.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:skill_check/main_app/flavour/flavour_config.dart';

import '../../test_data/dataReader.dart';

class MockEnrollExamRepository extends Mock implements SelfEnrollExamRepository {}

void main() {
  //setup test data


  group("Exam Enroll repository Group test", () {
    var responseJsonSuccess;
    //arrange
    setUp(() async {
//      FlavorConfig(values: FlavorValues(baseUrl: ""));
      responseJsonSuccess =
          await TestDataReader().readData("featured_exam_list_success.json");
    });

    test("enrollExamListFromJsonTest ith valid json should return valid list",
        () {
      // arrange
      var data = json.decode(responseJsonSuccess);

//      print(data[JsonKeys.data][JsonKeys.enrolledExamList]);

      //act
      var list = FeaturedExamListRepository.enrolledExamModelFromMapJson(data);

      //assert

      expect(list.length, 14);
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

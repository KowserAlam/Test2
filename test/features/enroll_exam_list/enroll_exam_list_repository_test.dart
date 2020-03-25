import 'dart:convert';

import 'package:assessment_ishraak/features/enrolled_exam_list_screen/repositories/enroll_exam_list_repository.dart';

import 'package:assessment_ishraak/features/enrolled_exam_list_screen/repositories/self_enroll_exam_repository.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

import '../../test_data/dataReader.dart';

class MockEnrollExamRepository extends Mock implements SelfEnrollExamRepository {}

void main() {
  //setup test data
  var responseDataSuccess = {
    "status": "success",
    "code": 200,
    "message": "Exam Successfully Enrolled",
    "result": {"reg_id": 70}
  };

  var responseDataFailled = {
    "status": "failed",
    "code": 401,
    "message": "Exam Enroll Failed",
    "result": {
      "user": {"reg_id": ""}
    }
  };

  group("Exam Enroll repository test", () {
    var responseJsonSuccess;
    //arrange
    setUp(() async {
      responseJsonSuccess =
          await TestDataReader().readData("enroll_exam_list_success.json");
    });

    test("enrollExamListFromJsonTest ith valid json should return valid list",
        () {
      // arrange
      var data = json.decode(responseJsonSuccess);

//      print(data[JsonKeys.data][JsonKeys.enrolledExamList]);

      //act
      var list = EnrollExamListRepository().enrolledExamModelFromMapJson(data);

      //assert

      expect(list.length, 5);
    });

    test("enrollExamListFromJsonTest invalid josn should return empty list",
        () {
      // arrange

      var data = {};

      //act
      var list = EnrollExamListRepository().enrolledExamModelFromMapJson(data);

      //assert

      expect(list.length, 0);
    });
  });
}

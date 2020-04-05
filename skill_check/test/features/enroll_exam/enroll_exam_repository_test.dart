import 'dart:convert';

import 'package:skill_check/features/enrolled_exam_list_screen/models/enroll_exam_response_model.dart';
import 'package:skill_check/features/enrolled_exam_list_screen/repositories/self_enroll_exam_repository.dart';
import 'package:skill_check/features/home_screen/models/dashboard_models.dart';
import 'package:skill_check/features/home_screen/repositories/base_dashboard_repository.dart';
import 'package:skill_check/features/home_screen/repositories/dashboard_repository.dart';
import 'package:skill_check/main_app/failure/exceptions.dart';
import 'package:skill_check/main_app/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockEnrollExamRepository extends Mock implements SelfEnrollExamRepository {}

void main() {
  MockEnrollExamRepository mockEnrollExamRepository;
  //setup test data
  var responseDataSuccess = {
    "status": "success",
    "code": 200,
    "message": "Exam Successfully Enrolled",
    "result": {
      "reg_id": 3
    }
  };

  var responseDataFailled = {
    "status": "failed",
    "code": 401,
    "message": "Exam Enroll Failed",
    "result": {
      "user": {
        "reg_id": ""
      }
    }
  };

  setUp(() {
    mockEnrollExamRepository = MockEnrollExamRepository();
  });

  group("Exam Enroll repository test", () {



    test("should return Right, enroll succcessful", () async {
      //arrange
      when(mockEnrollExamRepository.sendEnrollRequest(examId: "", userId: "")).thenAnswer((_) async =>
          Right(EnrollExamResponseModel.fromJson(responseDataFailled)));

      //act
      var response = await mockEnrollExamRepository.sendEnrollRequest(examId: "", userId: "");

      //assert

      expect(response.isRight(), true);
      verify(mockEnrollExamRepository.sendEnrollRequest(userId: "",examId: ""));
    });



    test("should return Right, response faild to enroll", () async {
      //arrange
      when(mockEnrollExamRepository.sendEnrollRequest(examId: "", userId: "")).thenAnswer((_) async =>
          Right(EnrollExamResponseModel.fromJson(responseDataSuccess)));

      //act
      var response = await mockEnrollExamRepository.sendEnrollRequest(examId: "", userId: "");

      //assert

      expect(response.isRight(), true);
      verify(mockEnrollExamRepository.sendEnrollRequest(userId: "",examId: ""));
    });

    test("should return Right with satus code 200,  enroll succcessful", () async {
      //arrange
      when(mockEnrollExamRepository.sendEnrollRequest(examId: "", userId: "")).thenAnswer((_) async =>
          Right(EnrollExamResponseModel.fromJson(responseDataSuccess)));

      //act
      var response = await mockEnrollExamRepository.sendEnrollRequest(examId: "", userId: "");

      //assert

      expect(response.fold((_)=>false, (EnrollExamResponseModel e)=>e.code), 200);
      verify(mockEnrollExamRepository.sendEnrollRequest(userId: "",examId: ""));
    });


    test("should return Right with satus code 401, response faild to enroll", () async {
      //arrange
      when(mockEnrollExamRepository.sendEnrollRequest(examId: "", userId: "")).thenAnswer((_) async =>
          Right(EnrollExamResponseModel.fromJson(responseDataFailled)));

      //act
      var response = await mockEnrollExamRepository.sendEnrollRequest(examId: "", userId: "");

      //assert

      expect(response.fold((_)=>false, (EnrollExamResponseModel e)=>e.code), 401);
      verify(mockEnrollExamRepository.sendEnrollRequest(userId: "",examId: ""));
    });




  });
}

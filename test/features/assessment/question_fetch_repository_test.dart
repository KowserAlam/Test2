import 'dart:io';

import 'package:assessment_ishraak/features/assessment/models/questions_model.dart';
import 'package:assessment_ishraak/features/assessment/repositories/question_fetch_repository.dart';
import 'package:assessment_ishraak/features/home_screen/models/dashboard_models.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockQuestionFetchRepository extends Mock
    implements QuestionFetchRepository {}

void main() {
  MockQuestionFetchRepository mockQuestionFetchRepository;
  List<QuestionModel> tQuestionList = [];

  //setup test data
  setUp(() {
    tQuestionList.add(QuestionModel(
      questionNumber: 123,
      isMarkedForReview: false,
      selectedAnswers: [],
      question: "asdfa",
    ));
    mockQuestionFetchRepository = MockQuestionFetchRepository();
//    dashBoardRepository = DashBoardRepository();
  });

  group("QuestionFetchRepository", () {

    test("should return lenght 1, response succcessful", () async {
      //arrange
      when(mockQuestionFetchRepository.fetchQuestion(""))
          .thenAnswer((_) async => Right(tQuestionList));

      //act
      var response = await mockQuestionFetchRepository.fetchQuestion("");

      response.fold((_){}, (data){

        expect( data.length, 1);
      });

      //assert


    });

  });
}

import 'dart:convert';
import 'package:p7app/features/assessment/models/questions_model.dart';
import 'package:p7app/features/home_screen/models/dashboard_models.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_data/dataReader.dart';

void main() {
  group("fromJson", () {
    //setup test data
    var tQuestinListLenght = 2;

    group("QuestionModel.fromJson test", () {
      var responseJsonSuccess;

      setUp(() async {
        responseJsonSuccess =
        await TestDataReader().readData("question_list_succcess.json");
      });


      test(
          "QuestionModel fromJson methode test with id, should returen a valid QuestionModel",
              () {
            /// arrange
            final Map<String, dynamic> jsonMap = json.decode(responseJsonSuccess);

            /// act
            final result = QuestionModel.fromJson(jsonMap["questionListWithAns"].first);

            /// assert
            expect("8",result.id.toString() );
          });

      test(
          "QuestionModel fromJson methode test with lenght, should returen a valid of 2",
              () {
            /// arrange
            final Map<String, dynamic> jsonMap = json.decode(responseJsonSuccess);


            /// act
            var result = jsonMap["questionListWithAns"].map((v)=>QuestionModel.fromJson(v)).toList();

            /// assert
            expect(tQuestinListLenght,result.length);
          });



    });
  });
}

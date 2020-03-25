import 'dart:convert';
import 'package:p7app/features/home_screen/models/dashboard_models.dart';
import 'package:p7app/features/auth/models/login_signup_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_data/dataReader.dart';

void main() {
  group("fromJson", () {
    //setup test data
    var tUserEmail = "shofi@ishraak.com";
    var tFeaturedExmListLength = 5;
    var tRecentExamLength = 1;
    var tEnrolledLength = 1;

    group("DeshboardModel.fromJson test", () {
      var responseJsonSuccess;

      setUp(() async {
        responseJsonSuccess =
            await TestDataReader().readData("dashboard_response_success.json");
      });


      test(
          "Dashboard model fromJson methode test, should returen a valid email",
          () {
        /// arrange
        final Map<String, dynamic> jsonMap = json.decode(responseJsonSuccess);

        /// act
        final result = DashBoardModel.fromJson(jsonMap);

        /// assert
        expect(result.user.email, tUserEmail);
      });


      test(
          "Dashboard model fromJson methode test, should returen featured exam lenght 12",
          () {
        /// arrange
        final Map<String, dynamic> jsonMap = json.decode(responseJsonSuccess);

        /// act
        final result = DashBoardModel.fromJson(jsonMap);

        /// assert
        expect(result.featuredExam.length, tFeaturedExmListLength);
      });


      test(
          "Dashboard model fromJson methode test, should returen recent exam lenght 3",
          () {
        /// arrange
        final Map<String, dynamic> jsonMap = json.decode(responseJsonSuccess);

        /// act
        final result = DashBoardModel.fromJson(jsonMap);

        /// assert
        expect(result.recentExam.length, tRecentExamLength);
      });


      test(
          "Dashboard model fromJson methode test, should returen registeredExam exam lenght 3",
          () {
        /// arrange
        final Map<String, dynamic> jsonMap = json.decode(responseJsonSuccess);

        /// act
        final result = DashBoardModel.fromJson(jsonMap);

        /// assert
        expect(result.enrolledExams.length, tEnrolledLength);
      });
    });
  });
}

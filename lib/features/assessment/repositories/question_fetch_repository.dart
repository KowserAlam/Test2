import 'dart:convert';

import 'package:p7app/features/assessment/models/exam_model.dart';
import 'package:p7app/features/assessment/models/questions_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/failure/exceptions.dart';
import 'package:p7app/main_app/failure/failure.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class QuestionFetchRepository {
  Future<Either<Failure, List<QuestionModel>>> fetchQuestion(
      String examId) async {
    try {
      var url = Urls.questionListUrl + "/$examId";

//      http.Response response =
//          await http.get(Urls.questionListUrl + "/$examId");

      http.Response response = await ApiClient().getRequest(url);

      print(response.statusCode);
      print(response.body);
      var model =
          ExamModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      if (response.statusCode == 200)
        return Right(model.questionListWithAns);
      else
        return Left(NotFoundExceptions());
    } catch (e) {
      print(e);
      return Left(ServerExceptions());
    }
  }
}

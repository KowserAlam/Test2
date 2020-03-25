import 'dart:convert';
import 'package:assessment_ishraak/features/enrolled_exam_list_screen/models/enroll_exam_response_model.dart';
import 'package:assessment_ishraak/main_app/api_helpers/api_client.dart';
import 'package:assessment_ishraak/main_app/failure/exceptions.dart';
import 'package:assessment_ishraak/main_app/failure/failure.dart';
import 'package:assessment_ishraak/main_app/api_helpers/urls.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class SelfEnrollExamBaseRepository {
  Future<Either<Failure, EnrollExamResponseModel>> sendEnrollRequest(
      {@required String examId, @required userId});
}

class SelfEnrollExamRepository {
  Future<Either<Failure, EnrollExamResponseModel>> sendEnrollRequest(
      {@required String examId, @required userId}) async {



    Map<String,dynamic> body = {
      "exam_id": examId,
      "professional_id": userId,
    };
//    http.Response response =
//    await ApiClient().postRequest(Urls.examEnrollUrl, body);
//    var mapJson = json.decode(response.body);
    try {
      print("enroll exam");
//      http.Response response =
//          await http.post(Urls.examEnrollUrl, body: json.encode(body));
      http.Response response =
      await ApiClient().postRequest(Urls.examEnrollUrl, body);
      var mapJson = json.decode(response.body);
      print(mapJson);
      return Right(EnrollExamResponseModel.fromJson(mapJson));
    } catch (e) {
      print(e);
      return Left(ServerExceptions());
    }
  }
}

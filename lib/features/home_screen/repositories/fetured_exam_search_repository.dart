import 'dart:convert';
import 'package:p7app/features/featured_exam_screen/models/featured_exam_model.dart';
import 'package:p7app/features/featured_exam_screen/repositories/featured_exam_list_repository.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/exceptions.dart';
import 'package:p7app/main_app/failure/failure.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class FeaturedExamSearchRepository {
  Future<Either<Failure, List<FeaturedExamModel>>> queryForFeaturedExam(
    String queryText,
  ) async {
    try {
      var authUser = await AuthService.getInstance();

      var url =
          "${Urls.searchFeaturedExamUrl}/${authUser.getUser().userId}?q=$queryText";
      var response = await ApiClient().getRequest(url);

//print(url);
      var mapJson = json.decode(response.body);

      List<FeaturedExamModel> featuredExamList = jsonFromMap(mapJson);
//      print(featuredExamList.length);
      return Right(featuredExamList);
    } catch (e) {
      print(e);
      return Left(ServerExceptions());
    }
  }

  jsonFromMap(mapJson) {
    return FeaturedExamListRepository.enrolledExamModelFromMapJson(mapJson);
  }
}

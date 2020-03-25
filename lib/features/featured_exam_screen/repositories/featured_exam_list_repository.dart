import 'dart:convert';

import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/models/exam_page_response_data_model.dart';
import 'package:p7app/features/home_screen/models/dashboard_models.dart';
import 'package:p7app/features/featured_exam_screen/models/featured_exam_model.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/exceptions.dart';
import 'package:p7app/main_app/failure/failure.dart';
import 'package:p7app/main_app/util/json_keys.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class FeaturedExamListRepository {
  Future<Either<Failure, ExamPageResponseDataModel<FeaturedExamModel>>> fetchFeaturedExamList(
      int pageNumber,{String queryText}) async {
    try {
      var authUser = await AuthService.getInstance();
      var userId = authUser.getUser().userId;

      /// http://{BASE_URL}/api/featured-examlist/{USER_ID}?page={PAGE_NUMBER}&q={QUERY_TEXT}
      var url = "${Urls.featuredExamListUrl}/$userId?page=$pageNumber&q=${queryText??""}";

      print(url);
      var response = await ApiClient().getRequest(url);

      var mapJson = json.decode(response.body);
      if (mapJson[JsonKeys.code] == 200) {
//        print(mapJson);
        List<FeaturedExamModel> list = enrolledExamModelFromMapJson(mapJson);

        bool nextPage = mapJson["next_pages"] as bool??false;
        var pageModel = ExamPageResponseDataModel<FeaturedExamModel>(examList: list, hasMoreData: nextPage);

        return Right(pageModel);
      } else {
        return Left(ServerExceptions());
      }
    } catch (e) {
      print(e);
      return Left(ServerExceptions());
    }
  }

  static List<FeaturedExamModel> enrolledExamModelFromMapJson(mapJson) {
    List<FeaturedExamModel> enrolledExamList;
    if (mapJson[JsonKeys.data] != null) {
      var dataMap = mapJson[JsonKeys.data];
      if (dataMap[JsonKeys.featuredExamList] != null) {
        var enrolledExamListMap = dataMap[JsonKeys.featuredExamList];
        enrolledExamList = new List<FeaturedExamModel>();
        enrolledExamListMap.forEach((v) {
          enrolledExamList.add(new FeaturedExamModel.fromJson(v));
        });

        return enrolledExamList;
      }
      return <FeaturedExamModel>[];
    }
    return <FeaturedExamModel>[];
  }
}

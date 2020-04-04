import 'dart:convert';
import 'package:p7app/features/enrolled_exam_list_screen/models/enrolled_exam_model.dart';
import 'package:p7app/features/recent_exam/models/recent_exam_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/exceptions.dart';
import 'package:p7app/main_app/failure/failure.dart';
import 'package:p7app/features/assessment/models/exam_page_response_data_model.dart';
import 'package:p7app/main_app/resource/json_keys.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class RecentExamListRepository {

  Future<Either<Failure, ExamPageResponseDataModel<RecentExamModel>>> fetchRecentExamList( int pageNumber,{String queryText}) async {
    try {
      var authUser = await AuthService.getInstance();
      var userId = authUser.getUser().userId;

      /// http://{BASE_URL}/api/enrolled-examlist/{USER_ID}?page={PAGE_NUMBER}&q={QUERY_TEXT}
      var url = "${Urls.recentExamListUrl}/$userId?page=$pageNumber&q=${queryText??""}";
      print(url);
//      var response = await http.get(url);

      var response = await ApiClient().getRequest(url);

      var mapJson = json.decode(response.body);
      if (mapJson[JsonKeys.code] == 200) {
//        print(mapJson);
        List<RecentExamModel> list = recentExamModelFromMapJson(mapJson);

        bool nextPage = mapJson["next_pages"] as bool??false;
        var pageModel = ExamPageResponseDataModel<RecentExamModel>(examList: list, hasMoreData: nextPage);

        return Right(pageModel);
      } else {
        return Left(ServerExceptions());
      }
    } catch (e) {
      print(e);
      return Left(ServerExceptions());
    }
  }

  List<RecentExamModel> recentExamModelFromMapJson(mapJson) {
    List<RecentExamModel> enrolledExamList;
    if (mapJson[JsonKeys.data] != null) {
      var dataMap = mapJson[JsonKeys.data];
      if (dataMap[JsonKeys.recentExamList] != null) {
        var enrolledExamListMap = dataMap[JsonKeys.recentExamList];
        enrolledExamList = new List<RecentExamModel>();
        enrolledExamListMap.forEach((v) {
          enrolledExamList.add(new RecentExamModel.fromJson(v));
        });

        return enrolledExamList;
      }
      return <RecentExamModel>[];
    }
    return <RecentExamModel>[];
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:skill_check/main_app/api_helpers/api_client.dart';
import 'package:meta/meta.dart';

import 'package:skill_check/features/home_screen/models/dashboard_models.dart';
import 'package:skill_check/features/home_screen/repositories/base_dashboard_repository.dart';
import 'package:skill_check/main_app/failure/exceptions.dart';
import 'package:skill_check/main_app/failure/failure.dart';
import 'package:skill_check/main_app/api_helpers/urls.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class DashBoardRepository implements BaseDashBoardRepository {
  @override
  Future<Either<Failure, DashBoardModel>> getDashboardData (
      {@required String userId}) async {
//    print("getting dashboard data");

    try {
      ApiClient apiClient = ApiClient();
      var response= await apiClient.getRequest(Urls.dashboardUrl+"/$userId");

//      var response = await http
//          .get(Urls.dashboardUrl + "/$userId")
//          .timeout(Duration(seconds: 10));

      var mapJson = json.decode(response.body);
//      print(mapJson);
      var dashboardModel = DashBoardModel.fromJson(mapJson);
//      print(mapJson);
      return Right(dashboardModel);
    } on SocketException {
      print("SocketException");
      return Left(NetworkExceptions());
    } catch (e) {
      print("Unable to Load data");
      print(e);
      return Left(ServerExceptions());
    }
  }
}

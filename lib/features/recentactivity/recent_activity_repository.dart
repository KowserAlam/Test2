import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:p7app/features/recentactivity/recentactivitymodel.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class RecentActivityRepository {
  Future<Either<AppError, List<RecentActivityModel>>> getActivities() async {
    var url = "${Urls.proRecentActivityUrl}";
    try {
      var res = await ApiClient().getRequest(url);
      logger.i(res.statusCode);
      logger.i(res.body);

      var decodeJson = json.decode(utf8.decode(res.bodyBytes));
      List<RecentActivityModel> list = [];
      decodeJson.forEach((e){
        list.add(RecentActivityModel.fromJson(e));
      });
      return Right(list);
    } catch (e) {
      logger.e(e);
      return Left(AppError.unknownError);
    }
  }
}

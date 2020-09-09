import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:logger/logger.dart';
import 'package:p7app/features/dashboard/models/info_box_data_model.dart';
import 'package:p7app/features/dashboard/models/skill_job_chart_data_model.dart';
import 'package:p7app/features/dashboard/models/top_categories_model.dart';
import 'package:p7app/features/dashboard/models/vital_stats_data_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class DashBoardRepository {
  Future<Either<AppError, InfoBoxDataModel>> getInfoBoxData() async {
    try {
      var res = await ApiClient().getRequest(Urls.dashboardInfoBoxUrl);
      logger.i(res.statusCode);
//      logger.i(res.body);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        var model = InfoBoxDataModel.fromJson(decodedJson);
        return Right(model);
      } else if (res.statusCode == 401) {
        return Left(AppError.unauthorized);
      } else {
        return Left(AppError.serverError);
      }
    } on SocketException catch (e) {
      logger.i(e);
      return Left(AppError.networkError);
    } catch (e) {
      logger.i(e);
      return Left(AppError.unknownError);
    }
  }

  Future<Either<AppError, List<SkillJobChartDataModel>>>
      getSkillJobChart() async {
    try {
      var res = await ApiClient().getRequest(Urls.dashboardSkillJobChartUrl);
//      logger.i(res.statusCode);
//      logger.i(res.body);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        List<SkillJobChartDataModel> data = [];
        decodedJson.forEach((e) {
          data.add(SkillJobChartDataModel.fromJson(e));
        });
        data.sort((a, b) => b.dateTimeValue.compareTo(a.dateTimeValue));
        return Right(data);
      } else {
        return Left(AppError.serverError);
      }
    } on SocketException catch (e) {
      logger.i(e);
      return Left(AppError.networkError);
    } catch (e) {
      logger.i(e);
      return Left(AppError.unknownError);
    }
  }

  Future<double> getProfileCompletenessPercent() async {
    try {
      var res = await ApiClient().getRequest(Urls.profileCompleteness);
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        return data['percent_of_profile_completeness']?.toDouble();
      } else {
        return 0;
      }
    } catch (e) {
      logger.i(e);
      return 0;
    }
  }

  Future<Either<AppError, VitalStatsDataModel>> getVitalStats() async {
    try {
      var res = await ApiClient().getRequest(Urls.vitalStatsUrl);
      logger.i(res.statusCode);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
       // Logger().i(decodedJson);
        var data = VitalStatsDataModel.fromJson(decodedJson);
        return Right(data);
      } else {
        return Left(AppError.serverError);
      }
    } on SocketException catch (e) {
      logger.i(e);
      return Left(AppError.networkError);
    } catch (e) {
      logger.i(e);
      return Left(AppError.unknownError);
    }
  }

  Future<Either<AppError, List<TopCategoriesModel>>> getTopCategories() async {
    try {
      var res = await ApiClient().getRequest(Urls.topCategoriesListUrl);
      logger.i(res.statusCode);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        // Logger().i(decodedJson);
        List<TopCategoriesModel> list = [];
        decodedJson.forEach((e)=>list.add(TopCategoriesModel.fromJson(e)));
        return Right(list);
      } else {
        return Left(AppError.serverError);
      }
    } on SocketException catch (e) {
      logger.i(e);
      return Left(AppError.networkError);
    } catch (e) {
      logger.i(e);
      return Left(AppError.unknownError);
    }
  }
}

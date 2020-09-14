import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/logger_helper.dart';


class FavoriteJobListRepository {
  Future<Either<AppError, FavouriteJobsScreenDataModel>> fetchJobList({page=1}) async {
    var url = "${Urls.favouriteJobListUrl}?page=$page";
    try {
      var response = await ApiClient().getRequest(url);
      debugPrint(url);
      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        var mapData = json.decode(utf8.decode(response.bodyBytes));
        var jobList = fromJson(mapData["results"]);
        return Right(FavouriteJobsScreenDataModel(
          jobList: jobList,
          hasMoreData: mapData["pages"]["next_url"] != null ?? false,
        ));
      } else {
        BotToast.showText(text: StringResources.somethingIsWrong);
        return Left(AppError.serverError);
      }
    } on SocketException catch (e) {
      logger.e(e);
      BotToast.showText(text: StringResources.unableToReachServerMessage);
      return Left(AppError.networkError);
    } catch (e) {
      logger.e(e);
      BotToast.showText(text: StringResources.somethingIsWrong);
      return Left(AppError.unknownError);
    }
  }

  List<JobListModel> fromJson(json) {
    List<JobListModel> jobList = new List<JobListModel>();
    if (json != null) {
      json.forEach((v) {
        jobList.add(new JobListModel.fromJson(v));
      });
    }

    return jobList;
  }
}
class FavouriteJobsScreenDataModel {
  List<JobListModel> jobList;
  bool hasMoreData;

  FavouriteJobsScreenDataModel({this.jobList, this.hasMoreData});
}

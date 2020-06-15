import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/features/job/models/job_list_filters.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';


class AppliedJobListRepository {

  Future<Either<AppError, List<JobListModel>>> fetchJobList() async {

    var url = "${Urls.appliedJobListUrl}";

    try {
      var response = await ApiClient().getRequest(url);
      debugPrint(url);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var mapData = json.decode(response.body);
        var jobList = fromJson(mapData);
        return Right(jobList);
      } else {
        BotToast.showText(text: StringUtils.somethingIsWrong);
        return Left(AppError.serverError);
      }
    } on SocketException catch (e) {
      print(e);
      BotToast.showText(text: StringUtils.unableToReachServerMessage);
      return Left(AppError.networkError);
    } catch (e) {
      print(e);
      BotToast.showText(text: StringUtils.somethingIsWrong);
      return Left(AppError.unknownError);
    }
  }

  List<JobListModel> fromJson( json) {
    List<JobListModel> jobList = new List<JobListModel>();
    if (json != null) {
      json.forEach((v) {
        jobList.add(new JobListModel.fromJson(v));
      });
    }
    return jobList;
  }
}

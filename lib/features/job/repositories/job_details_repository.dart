import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/features/job/models/job_list_filters.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/error.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

/// http://dev.ishraak.com/api/job_list/?page=1&q=job&location=&category=
/// &location_from_homepage=&keyword_from_homepage=&skill=&salaryMin=
/// &salaryMax=&experienceMin=&experienceMax=null&datePosted=&gender=
/// &qualification=&sort=&page_size=10
class JobDetailsRepository {

  Future<Either<AppError, JobListScreenDataModel>> fetchJobList(
      String slug) async {


    var url = "${Urls.jobDetailsUrl}";

    try {
      var response = await ApiClient().getRequest(url);
      debugPrint(url);
      print(response.statusCode);
//      print(response.body);
      if (response.statusCode == 200) {
        var mapData = json.decode(response.body);

        var jobList = fromJson(mapData);
        var dataModel = JobListScreenDataModel(
            jobList: jobList,
            count: mapData['count'],
            nextPage: mapData['next_pages']??false);
        return Right(dataModel);
      } else {
        BotToast.showText(text: StringUtils.somethingIsWrong);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      print(e);
      BotToast.showText(text: StringUtils.checkInternetConnectionMessage);
      return Left(AppError.networkError);
    } catch (e) {
      print(e);
      BotToast.showText(text: StringUtils.somethingIsWrong);
      return Left(AppError.serverError);
    }
  }

  List<JobModel> fromJson(Map<String, dynamic> json) {
    List<JobModel> jobList = new List<JobModel>();
    if (json['results'] != null) {
      json['results'].forEach((v) {
        jobList.add(new JobModel.fromJson(v));
      });
    }
    return jobList;
  }

}

class JobListScreenDataModel {
  int count;
  bool nextPage;
  List<JobModel> jobList;

  JobListScreenDataModel({
    @required this.count,
    @required this.nextPage,
    @required this.jobList,
  });
}

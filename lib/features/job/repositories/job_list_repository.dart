import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/error.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

/// http://dev.ishraak.com/api/job_list/?page=1&q=job&location=&category=
/// &location_from_homepage=&keyword_from_homepage=&skill=&salaryMin=
/// &salaryMax=&experienceMin=&experienceMax=null&datePosted=&gender=
/// &qualification=&sort=&page_size=10
class JobListRepository {
  int count;
  bool next;

  Future<Either<AppError, List<JobModel>>> fetchJobList({
    int page = 1,
    int page_size = 15,
    String searchQuery='',
    String location='',
    String category='',
    String location_from_homepage='',
    String keyword_from_homepage='',
    String skill='',
    String salaryMin='',
    String salaryMax='',
    String experienceMin='',
    String experienceMax='',
    String datePosted='',
    String gender='',
    String qualification='',
    String sort='',
  }) async {

    var filters = "?page=$page&q=$searchQuery&location=$location&category=$category"
        "&location_from_homepage=$location_from_homepage&keyword_from_homepage=$keyword_from_homepage"
        "&skill=$skill&salaryMin=$salaryMin&salaryMax=$salaryMin&experienceMin=$experienceMin"
        "&experienceMax=$experienceMax&datePosted=$datePosted&gender=$gender"
        "&qualification=$qualification&sort=$sort&page_size=$page_size";

    var url = "${Urls.jobListUrl}${filters}";

    try {
      var response = await ApiClient().getRequest(url);
      debugPrint(url);
      print(response.statusCode);
//      print(response.body);
      if (response.statusCode == 200) {
        var mapData = json.decode(response.body);
        var jobList = fromJson(mapData);
        return Right(jobList);
      } else {
        BotToast.showText(text: StringUtils.somethingIsWrong);
        return Left(AppError.serverError);
      }
    } on SocketException catch (e){
      print(e);
      BotToast.showText(text: StringUtils.checkInternetConnectionMessage);
      return Left(AppError.networkError);
    }

    catch (e) {
      print(e);
      BotToast.showText(text: StringUtils.somethingIsWrong);
      return Left(AppError.serverError);
    }
  }

  List<JobModel> fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next_pages'];
    List<JobModel> jobList = new List<JobModel>();
    if (json['results'] != null) {
      json['results'].forEach((v) {
        jobList.add(new JobModel.fromJson(v));
      });
    }

    return jobList;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/features/job/models/job_list_filters.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/error.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

/// http://dev.ishraak.com/api/job_list/?page=1&q=job&location=&category=
/// &location_from_homepage=&keyword_from_homepage=&skill=&salaryMin=
/// &salaryMax=&experienceMin=&experienceMax=null&datePosted=&gender=
/// &qualification=&sort=&page_size=10
class JobRepository {

  Future<Either<AppError, JobListScreenDataModel>> fetchJobList(
      JobListFilters filters) async {

    var _filters =
        "?page=${filters.page}&q=${filters.searchQuery??""}&location=${filters.location??""}&category=${filters.category??""}"
        "&location_from_homepage=${filters.location_from_homepage??""}&keyword_from_homepage=${filters.keyword_from_homepage??""}"
        "&skill=${filters.skill??""}&salaryMin=${filters.salaryMin??""}&salaryMax=${filters.salaryMax??""}&experienceMin=${filters.experienceMin??""}"
        "&experienceMax=${filters.experienceMax??""}&datePosted=${filters.datePosted??""}&gender=${filters.gender??""}&job_type=${filters.jobType?.id??""}"
        "&qualification=${filters.qualification??""}&sort=${filters?.sort?.key??""}"
        "&page_size=${filters.page_size}&top-skill=${filters.topSkill??""}";

    var url = "${Urls.jobListUrl}${_filters}";

    try {
      var response = await ApiClient().getRequest(url);
      debugPrint(url);
      print(response.statusCode);
//      print(response.body);
      if (response.statusCode == 200) {
        var mapData = json.decode(utf8.decode(response.bodyBytes));


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

  Future<Either<AppError, JobModel>> fetchJobDetails(
      String slug) async {


    //var url = "/api/load_job/seo-expert-78caf3ac";
    var url = "${Urls.jobDetailsUrl}${slug}";

    try {
      var response = await ApiClient().getRequest(url);
      debugPrint(url);
      print(response.statusCode);
//      print(response.body);
      if (response.statusCode == 200) {
        var mapData = json.decode(utf8.decode(response.bodyBytes));

        var jobDetails = JobModel.fromJson(mapData);
        return Right(jobDetails);
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

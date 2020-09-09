import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:logger/logger.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/features/job/models/job_list_filters.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

/// http://dev.ishraak.com/api/job_list/?page=1&q=job&location=&category=
/// &location_from_homepage=&keyword_from_homepage=&skill=&salaryMin=
/// &salaryMax=&experienceMin=&experienceMax=null&datePosted=&gender=
/// &qualification=&sort=&page_size=10
///
/// query = request.GET.get('q')
///current_url = request.GET.get('current_url')
///sorting = request.GET.get('sort')
///category = request.GET.get('category')
///district = request.GET.get('location')
///skill = request.GET.get('skill')
///job_city = request.GET.get('job_city')
///salaryMin = request.GET.get('salaryMin')
///salaryMax = request.GET.get('salaryMax')
///experienceMin = request.GET.get('experienceMin')
///experienceMax = request.GET.get('experienceMax')
///datePosted = request.GET.get('datePosted')
///gender = request.GET.get('gender')
///job_type = request.GET.get('job_type')
///qualification = request.GET.get('qualification')
///topSkill = request.GET.get('top-skill')
///

class JobRepository {
  Future<Either<AppError, JobListScreenDataModel>> fetchJobList(
      JobListFilters filters) async {
    var _filters =
        "?page=${filters.page}&q=${filters.searchQuery ?? ""}&category=${filters.category ?? ""}"
        "&skill=${filters.skill?.id ?? ""}&salaryMin=${filters.salaryMin ?? ""}&salaryMax=${filters.salaryMax ?? ""}&experienceMin=${filters.experienceMin ?? ""}"
        "&experienceMax=${filters.experienceMax ?? ""}&datePosted=${filters.datePosted ?? ""}&gender=${filters.gender ?? ""}&job_type=${filters.jobType?.id ?? ""}"
        "&qualification=${filters.qualification ?? ""}&sort=${filters?.sort?.key ?? ""}"
        "&page_size=${filters.page_size}&top-skill=${filters.topSkill ?? ""}"
        "&job_city=${filters.location ?? ""}";

    var url = "${Urls.jobListUrl}${_filters}";

    try {
      var response = await ApiClient().getRequest(url);
     logger.i(url);
      logger.i(response.statusCode);
//      print(response.body);
      if (response.statusCode == 200) {
        var decodedJson = json.decode(utf8.decode(response.bodyBytes));
//        Logger().i(decodedJson);
        var jobList = fromJson(decodedJson);
        var dataModel = JobListScreenDataModel(
          jobList: jobList,
          count: decodedJson['count'],
          nextPage: decodedJson['pages'] != null
              ? decodedJson['pages']['next_url'] != null
              : false,
//        nextPage: decodedJson["next_pages"]??false,
        );
        return Right(dataModel);
      } else if (response.statusCode == 401) {
        BotToast.showText(text: StringResources.unauthorizedText);
        return Left(AppError.unauthorized);
      } else {
        BotToast.showText(text: StringResources.somethingIsWrong);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      print(e);
      BotToast.showText(text: StringResources.unableToReachServerMessage);
      return Left(AppError.networkError);
    } catch (e) {
      print(e);
      BotToast.showText(text: StringResources.somethingIsWrong);
      return Left(AppError.serverError);
    }
  }

  List<JobListModel> fromJson(Map<String, dynamic> json) {
    List<JobListModel> jobList = new List<JobListModel>();
    if (json['results'] != null) {
      json['results'].forEach((v) {
        jobList.add(new JobListModel.fromJson(v));
      });
    }
    return jobList;
  }

  /// JOB Details
  Future<Map<String, dynamic>> _getJobDetailsBody(
      String url, bool forceFromServer) async {
      var response = await ApiClient().getRequest(url);
      debugPrint(url);
      print(response.statusCode);
//      print(response.body);
      if (response.statusCode == 200) {
        var decodedJson = json.decode(utf8.decode(response.bodyBytes));
        Cache.remember(url, decodedJson, 30 * 60);
        return decodedJson;
      } else {
        return null;
      }

  }

  Future<Either<AppError, JobModel>> fetchJobDetails(String slug,
      {bool forceFromServer = false}) async {
    //var url = "/api/load_job/seo-expert-78caf3ac";
    var url = "${Urls.jobDetailsUrl}${slug}";

    try {
      Map<String, dynamic> decodedJson =
          await _getJobDetailsBody(url, forceFromServer);

//      Logger().i(decodedJson);
      var jobDetails = JobModel.fromJson(decodedJson);
      return Right(jobDetails);
    } on SocketException catch (e) {
      print(e);
      BotToast.showText(text: StringResources.unableToReachServerMessage);
      return Left(AppError.networkError);
    } catch (e) {
      print(e);
      BotToast.showText(text: StringResources.somethingIsWrong);
      return Left(AppError.serverError);
    }
  }

  Future<bool> applyForJob(String jobId, {ApiClient apiClient}) async {
    BotToast.showLoading();
    var userId =
        await AuthService.getInstance().then((value) => value.getUser().userId);
    var body = {'user_id': userId, 'job_id': jobId};

    try {
      ApiClient client = apiClient ?? ApiClient();
      var res = await client.postRequest(Urls.applyJobOnlineUrl, body);
      print(res.body);

      if (res.statusCode == 200) {
        BotToast.closeAllLoading();
        BotToast.showText(
            text: StringResources.successfullyAppliedText,
            duration: Duration(seconds: 2));
        return true;
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToApplyText);
        return false;
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToReachServerMessage);
      print(e);
      return false;
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToApplyText);
      print(e);
      return false;
    }
  }

  Future<bool> addToFavorite(String jobId, {ApiClient apiClient}) async {
    BotToast.showLoading();
    var userId =
        await AuthService.getInstance().then((value) => value.getUser().userId);
    var body = {'user_id': userId, 'job_id': jobId};

    try {
      ApiClient client = apiClient ?? ApiClient();
      var res = await client.postRequest(Urls.favouriteJobAddUrl, body);
      print(res.body);

      if (res.statusCode == 200) {
        BotToast.closeAllLoading();
        return true;
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToAddAsFavoriteText);
        return false;
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToReachServerMessage);
      print(e);
      return false;
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToAddAsFavoriteText);
      print(e);
      return false;
    }
  }

  Future<List<JobListModel>> getSimilarJobs(String jobId) async {
    var url = "${Urls.similarJobs}/$jobId/";

    try {
      var res = await ApiClient().getRequest(url);
      print(res.statusCode);
      if (res.statusCode == 200) {
        var _list = <JobListModel>[];
        var decodedJso = json.decode(utf8.decode(res.bodyBytes));
        decodedJso.forEach((element) {
          _list.add(JobListModel.fromJson(element));
        });
        return _list;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<JobListModel>> getOpenJobs(String companyName) async {
    var url = "${Urls.openJobsCompany}$companyName";

    try {
      var res = await ApiClient().getRequest(url);
      print(res.statusCode);
      if (res.statusCode == 200) {
        var _list = <JobListModel>[];
        var decodedJso = json.decode(utf8.decode(res.bodyBytes));

        decodedJso['results'].forEach((element) {
          _list.add(JobListModel.fromJson(element));
        });
        return _list;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}

class JobListScreenDataModel {
  int count;
  bool nextPage;
  List<JobListModel> jobList;

  JobListScreenDataModel({
    @required this.count,
    @required this.nextPage,
    @required this.jobList,
  });
}

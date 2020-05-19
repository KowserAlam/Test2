import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/features/job/models/job_list_filters.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/error.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

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
        "?page=${filters.page}&q=${filters.searchQuery ?? ""}&location=${filters.location ?? ""}&category=${filters.category ?? ""}"
        "&location_from_homepage=${filters.location_from_homepage ?? ""}&keyword_from_homepage=${filters.keyword_from_homepage ?? ""}"
        "&skill=${filters.skill?.id ?? ""}&salaryMin=${filters.salaryMin ?? ""}&salaryMax=${filters.salaryMax ?? ""}&experienceMin=${filters.experienceMin ?? ""}"
        "&experienceMax=${filters.experienceMax ?? ""}&datePosted=${filters.datePosted ?? ""}&gender=${filters.gender ?? ""}&job_type=${filters.jobType?.id ?? ""}"
        "&qualification=${filters.qualification ?? ""}&sort=${filters?.sort?.key ?? ""}"
        "&page_size=${filters.page_size}&top-skill=${filters.topSkill ?? ""}"
        "&job_city=${filters.jobCity ?? ""}";

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
            nextPage: mapData['next_pages'] ?? false);
        return Right(dataModel);
      } else if (response.statusCode == 401) {
        BotToast.showText(text: StringUtils.unauthorizedText);
        return Left(AppError.unauthorized);
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

  List<JobListModel> fromJson(Map<String, dynamic> json) {
    List<JobListModel> jobList = new List<JobListModel>();
    if (json['results'] != null) {
      json['results'].forEach((v) {
        jobList.add(new JobListModel.fromJson(v));
      });
    }
    return jobList;
  }

  Future<Either<AppError, JobModel>> fetchJobDetails(String slug) async {
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
            text: StringUtils.successfullyAppliedText,
            duration: Duration(seconds: 2));
        return true;
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToApplyText);
        return false;
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.checkInternetConnectionMessage);
      print(e);
      return false;
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToApplyText);
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
        BotToast.showText(text: StringUtils.unableToAddAsFavoriteText);
        return false;
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.checkInternetConnectionMessage);
      print(e);
      return false;
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToAddAsFavoriteText);
      print(e);
      return false;
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

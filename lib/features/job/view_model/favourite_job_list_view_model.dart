import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/features/job/models/job_list_filters.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/repositories/applied_job_list_repository.dart';
import 'package:p7app/features/job/repositories/favourite_job_list_repository.dart';
import 'package:p7app/features/job/repositories/job_repository.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/debouncer.dart';
import 'package:rxdart/rxdart.dart';

class FavouriteJobListViewModel with ChangeNotifier {
  List<JobListModel> _jobList = [];
  bool _isFetchingData = false;

  FavoriteJobListRepository _jobListRepository = FavoriteJobListRepository();


  /// ##########################
  /// methods
  /// #########################
  Future<bool> applyForJob(String jobId, int index,
      {ApiClient apiClient}) async {
    bool isSuccessful = await JobRepository().applyForJob(jobId);
    if (isSuccessful) {
      _jobList[index].isApplied = true;
      notifyListeners();
      return isSuccessful;
    } else {
      return isSuccessful;
    }
  }

  Future<bool> addToFavorite(String jobId, int index,
      {ApiClient apiClient}) async {

    bool isSuccessful = await JobRepository().addToFavorite(jobId);
    if (isSuccessful) {
      _jobList[index].isFavourite = !_jobList[index].isFavourite;
      notifyListeners();
      return isSuccessful;
    } else {
      return isSuccessful;
    }
  }

  Future<bool> refresh() async{
    return getJobList();
  }

  Future<bool> getJobList() async {
    isFetchingData = true;
    Either<AppError, List<JobListModel>> result =
    await _jobListRepository.fetchJobList();
    return result.fold((l) {
      isFetchingData = false;
      print(l);
      return false;
    }, (List<JobListModel> list) {
      isFetchingData = false;
      _jobList = list;
      notifyListeners();
      return true;
    });
  }

  resetState() {
    _jobList = [];
    _isFetchingData = false;
    _jobListRepository = FavoriteJobListRepository();
  }

  /// ##########################
  /// getter setters
  /// #########################

  List<JobListModel> get jobList => _jobList;

  set jobList(List<JobListModel> value) {
    _jobList = value;
    notifyListeners();
  }

  bool get isFetchingData => _isFetchingData;

  set isFetchingData(bool value) {
    _isFetchingData = value;
    notifyListeners();
  }


  set jobListRepository(FavoriteJobListRepository value) {
    _jobListRepository = value;
  }

}

import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/features/job/models/job_list_filters.dart';
import 'package:p7app/features/job/repositories/job_list_repository.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/error.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/debouncer.dart';
import 'package:rxdart/rxdart.dart';

class JobListViewModel with ChangeNotifier {
  List<JobModel> _jobList = [];
  bool _isFetchingData = false;
  bool _isFetchingMoreData = false;
  bool _hasMoreData = false;
  int _pageCount = 1;
  JobListRepository _jobListRepository = JobListRepository();
  JobListFilters _jobListFilters = JobListFilters();
  Debouncer _debouncer = Debouncer(milliseconds: 800);
  bool _isInSearchMode = false;
  int _totalJobCount = 0;

  int get totalJobCount => _totalJobCount;

  set totalJobCount(int value) {
    _totalJobCount = value;
    notifyListeners();
  }

  bool get isFetchingMoreData => _isFetchingMoreData;

  set isFetchingMoreData(bool value) {
    _isFetchingMoreData = value;
    notifyListeners();
  }

  /// ##########################
  /// methods
  /// #########################

  toggleIsInSearchMode() {
    _jobList = [];
    _isInSearchMode = !_isInSearchMode;
    _totalJobCount = 0;
    resetPageCounter();
//    _jobListFilters = JobListFilters();
    if (!_isInSearchMode) {
      getJobList();
    }
    notifyListeners();
  }

  addSearchQuery(String query) {
    _debouncer.run(() {
      _jobList = [];
      resetPageCounter();
      _jobListFilters.page = _pageCount;
      _jobListFilters.searchQuery = query;
      debugPrint("Searching for: $query");
      getJobList();
    });
  }

  void incrementPageCount() {
    _pageCount++;
  }

  void resetPageCounter() {
    _pageCount = 1;
    _jobListFilters.page = _pageCount;
  }

  Future<bool> refresh() async {
    _jobListFilters = JobListFilters();
    _pageCount = 1;
    notifyListeners();
    return getJobList();
  }

  Future<bool> getJobList() async {
    isFetchingData = true;
    totalJobCount = 0;

    Either<AppError, JobListScreenDataModel> result =
        await _jobListRepository.fetchJobList(_jobListFilters);
    return result.fold((l) {
      _hasMoreData = false;
      isFetchingData = false;
      _totalJobCount = 0;
      print(l);
      return false;
    }, (JobListScreenDataModel dataModel) {
      var list = dataModel.jobList;
      isFetchingData = false;
      _jobList = list;
      _totalJobCount = dataModel.count;
      _hasMoreData = dataModel.nextPage;
      notifyListeners();
      return true;
    });
  }

  getMoreData() async {
    if (!isFetchingData && !isFetchingMoreData && hasMoreData) {
      isFetchingMoreData = true;
      debugPrint('Getting more jobs');
      hasMoreData = true;
      incrementPageCount();
      _jobListFilters.page = _pageCount;
      Either<AppError, JobListScreenDataModel> result =
          await _jobListRepository.fetchJobList(_jobListFilters);
      result.fold((l) {
        _isFetchingMoreData = false;
        _hasMoreData = false;
        _totalJobCount = 0;
        notifyListeners();

        print(l);
      }, (JobListScreenDataModel dataModel) {
        // right
        var list = dataModel.jobList;
        _totalJobCount = dataModel.count;
        _hasMoreData = dataModel.nextPage;
        _jobList.addAll(list);
        _isFetchingMoreData = false;
        notifyListeners();
      });
    }
  }

  Future<bool> applyForJob(String jobId, int index,
      {ApiClient apiClient}) async {
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
        _jobList[index].isApplied = true;
        notifyListeners();
        return true;
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return false;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);

      return false;
    }
  }

  Future<bool> addToFavorite(String jobId, int index,
      {ApiClient apiClient}) async {
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

        _jobList[index].status = !_jobList[index].status;
        notifyListeners();
        return true;
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return false;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);

      return false;
    }
  }

  resetState() {
    _jobList = [];
    _isFetchingData = false;
    _hasMoreData = false;
    _pageCount = 1;
    _jobListRepository = JobListRepository();
    _jobListFilters = JobListFilters();
    notifyListeners();
  }

  /// ##########################
  /// getter setters
  /// #########################

  List<JobModel> get jobList => _jobList;

  set jobList(List<JobModel> value) {
    _jobList = value;
    notifyListeners();
  }

  bool get isFetchingData => _isFetchingData;

  set isFetchingData(bool value) {
    _isFetchingData = value;
    notifyListeners();
  }

  bool get hasMoreData => _hasMoreData;

  set hasMoreData(bool value) {
    _hasMoreData = value;
    notifyListeners();
  }

  bool get isInSearchMode => _isInSearchMode;

  set isInSearchMode(bool value) {
    _isInSearchMode = value;
  }

  set jobListRepository(JobListRepository value) {
    _jobListRepository = value;
  }
}

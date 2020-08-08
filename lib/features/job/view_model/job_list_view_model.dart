import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/models/job_list_filters.dart';
import 'package:p7app/features/job/models/sort_item.dart';
import 'package:p7app/features/job/repositories/job_repository.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/util/common_serviec_rule.dart';
import 'package:p7app/main_app/util/debouncer.dart';
import 'package:p7app/method_extension.dart';

class JobListViewModel with ChangeNotifier {
  List<JobListModel> _jobList = [];
  bool _isFetchingData = false;
  bool _isFetchingMoreData = false;
  bool _hasMoreData = false;
  int _pageCount = 1;
  JobRepository _jobListRepository = JobRepository();
  JobListFilters _jobListFilters = JobListFilters();
  Debouncer _debouncer = Debouncer(milliseconds: 800);
  bool _isInSearchMode = false;
  int _totalJobCount = 0;
  AppError _appError;
  DateTime _lastFetchTime;

  AppError get appError => _appError;

  set appError(AppError value) {
    _appError = value;
    notifyListeners();
  }

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

  JobListFilters get jobListFilters => _jobListFilters;

  /// ##########################
  /// methods
  /// #########################

  jobListSortBy(SortItem sort) {
    _jobListFilters.sort = sort;
    notifyListeners();
    getJobList();
  }

  toggleIsInSearchMode() {
//    _jobList = [];
    _isInSearchMode = !_isInSearchMode;
    _totalJobCount = 0;
    resetPageCounter();
//    _jobListFilters = JobListFilters();
    if (!_isInSearchMode) {
      _jobListFilters.searchQuery = "";
      getJobList();
    }
    notifyListeners();
  }

  addSearchQueryDebounceTime(String query) {
    _debouncer.run(() {
      search(query);
    });
  }

  search(String query) {
    _jobList = [];
    resetPageCounter();
    _jobListFilters.page = _pageCount;
    _jobListFilters.searchQuery = query;
    debugPrint("Searching for: $query");
    getJobList();
  }

  applyFilters(JobListFilters filters) {
    _jobList = [];
    resetPageCounter();
    _jobListFilters.page = _pageCount;
    _jobListFilters = filters;
    getJobList();
  }

  clearFilters() {
    resetPageCounter();
    _jobListFilters.page = _pageCount;
    _jobListFilters = JobListFilters(searchQuery: _jobListFilters.searchQuery);
    getJobList();
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

  Future<bool> getJobList({bool isFormOnPageLoad = false}) async {
    _totalJobCount = 0;
    _appError = null;

    if (isFormOnPageLoad) {
      bool shouldNotFetchData = CommonServiceRule.instance
          .shouldNotFetchData(_lastFetchTime, _appError);
      if (shouldNotFetchData) return null;
    }

    _isFetchingData = true;
    notifyListeners();

    Either<AppError, JobListScreenDataModel> result =
        await _jobListRepository.fetchJobList(_jobListFilters);
    return result.fold((l) {
      _hasMoreData = false;
      _isFetchingData = false;
      _totalJobCount = 0;
      _appError = l;
      notifyListeners();
      print(l);
      return false;
    }, (JobListScreenDataModel dataModel) {
      _lastFetchTime = DateTime.now();
      var list = dataModel.jobList;
      isFetchingData = false;
      _jobList = list;
      _totalJobCount = dataModel.count;
      _hasMoreData = dataModel.nextPage;
      appError = null;
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

  resetState() {
    _jobList = [];
    _isFetchingData = false;
    _hasMoreData = false;
    _pageCount = 1;
    _jobListRepository = JobRepository();
    _jobListFilters = JobListFilters();
    notifyListeners();
  }

  void clearSort() {
    _jobListFilters.sort = null;
    notifyListeners();
    getJobList();
  }

  void clearGender() {
    _jobListFilters.gender = null;
    notifyListeners();
    getJobList();
  }

  void clearCategory() {
    _jobListFilters.category = null;
    notifyListeners();
    getJobList();
  }

  void clearQualification() {
    _jobListFilters.qualification = null;
    notifyListeners();
    getJobList();
  }

  void clearLocation() {
    _jobListFilters.location = null;
    notifyListeners();
    getJobList();
  }

  void clearSkill() {
    _jobListFilters.skill = null;
    notifyListeners();
    getJobList();
  }

  void clearJobType() {
    _jobListFilters.jobType = null;
    notifyListeners();
    getJobList();
  }

  void clearDatePosted() {
    _jobListFilters.datePosted = null;
    notifyListeners();
    getJobList();
  }

  void clearSalaryRange() {
    _jobListFilters.salaryMax = null;
    _jobListFilters.salaryMin = null;
    notifyListeners();
    getJobList();
  }

  void clearExperienceRange() {
    _jobListFilters.experienceMax = null;
    _jobListFilters.experienceMin = null;
    notifyListeners();
    getJobList();
  }

  /// ##########################
  /// getter setters
  /// #########################

  bool get shouldShowAppError => _appError != null && _jobList.length == 0;

  bool get hasSortBy => _jobListFilters.sort?.key?.isNotEmptyOrNotNull ?? false;

  bool get hasGender => _jobListFilters.gender.isNotEmptyOrNotNull;

  bool get hasCategory => _jobListFilters.category.isNotEmptyOrNotNull;

  bool get hasQualification =>
      _jobListFilters.qualification.isNotEmptyOrNotNull;

  bool get hasLocation => _jobListFilters.location.isNotEmptyOrNotNull;

  bool get hasSkill => _jobListFilters.skill?.id?.isNotEmptyOrNotNull ?? false;

  bool get hasJobType =>
      _jobListFilters.jobType?.id?.isNotEmptyOrNotNull ?? false;

  bool get hasDatePosted => _jobListFilters.datePosted.isNotEmptyOrNotNull;

  bool get hasSalaryRange =>
      _jobListFilters.salaryMin.isNotEmptyOrNotNull ||
      _jobListFilters.salaryMax.isNotEmptyOrNotNull;

  bool get hasExperienceRange =>
      _jobListFilters.experienceMin.isNotEmptyOrNotNull ||
      _jobListFilters.experienceMax.isNotEmptyOrNotNull;

  bool get isFilterApplied {
    return hasGender ||
        hasQualification ||
        hasSortBy ||
        hasCategory ||
        hasLocation ||
        hasJobType ||
        hasDatePosted ||
        hasSalaryRange ||
        hasSkill ||
        hasExperienceRange;
  }

  bool get hasSearchQuery => _jobListFilters.searchQuery.isNotEmptyOrNotNull;

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

  bool get hasMoreData => _hasMoreData;

  set hasMoreData(bool value) {
    _hasMoreData = value;
    notifyListeners();
  }

  bool get isInSearchMode => _isInSearchMode;

  set isInSearchMode(bool value) {
    _isInSearchMode = value;
  }

  set jobListRepository(JobRepository value) {
    _jobListRepository = value;
  }

  bool get shouldShowNoJobsFound => jobList.length == 0 && !isFetchingData;

  bool get shouldShowPageLoader =>
      _jobList.length == 0 &&
      _isFetchingData &&
      !isFilterApplied &&
      !hasSearchQuery;

  bool get shouldSearchNFilterLoader =>
      _isFetchingData && (hasSearchQuery || isFilterApplied);
}

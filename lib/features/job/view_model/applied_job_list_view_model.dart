import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/repositories/applied_job_list_repository.dart';
import 'package:p7app/features/job/repositories/job_repository.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class AppliedJobListViewModel extends GetxController {
  var appError = AppError.none.obs;
  var jobListApplied = <JobListModel>[].obs;
  var isFetchingData = false.obs;
  var isFetchingMoreData = false.obs;
  bool hasMoreData = false;
  var _page = 1;

  void onClose() {
    appError.close();
    jobListApplied.close();
    isFetchingData.close();
    isFetchingData.close();
    isFetchingMoreData.close();
    super.onClose();
  }

  /// ##########################
  /// methods
  /// #########################

  Future<bool> refresh() async {
    return getJobList();
  }

  Future<bool> getJobList() async {
    _page = 1;
    isFetchingData.value = true;

    Either<AppError, AppliedJobsScreenDataModel> result =
        await AppliedJobListRepository().fetchJobList();
    return result.fold((l) {
      isFetchingData.value = false;
      logger.i(l);
      return false;
    }, (r) {
      hasMoreData = r.hasMoreData;
      isFetchingData.value = false;
      jobListApplied.value = r.jobList;
      return true;
    });
  }

  getMoreData() async {
    // logger.i("getting more data");

    if (!isFetchingMoreData.value && !isFetchingData.value && hasMoreData) {
      _page++;
      isFetchingMoreData.value = true;
      Either<AppError, AppliedJobsScreenDataModel> result =
          await AppliedJobListRepository().fetchJobList(page: _page);
      return result.fold((l) {
        isFetchingMoreData.value = false;
        hasMoreData = false;
        logger.i(l);
        return false;
      }, (r) {
        hasMoreData = r.hasMoreData;
        isFetchingMoreData.value = false;
        jobListApplied.value = r.jobList;
        return true;
      });
    }
  }

  resetState() {
    jobListApplied.value = [];
    isFetchingData.value = false;
    _page = 0;
  }

  /// ##########################
  /// getter setters
  /// #########################

  bool get shouldShowLoader =>
      isFetchingData.value && jobListApplied.length == 0;

  bool get shouldShowNoJobs =>
      !isFetchingData.value && jobListApplied.length == 0;

  // Future<bool> applyForJob(String jobId, int index,
  //     {ApiClient apiClient}) async {
  //   bool isSuccessful = await JobRepository().applyForJob(jobId);
  //   if (isSuccessful) {
  //     jobListApplied[index].isApplied = true;
  //     return isSuccessful;
  //   } else {
  //     return isSuccessful;
  //   }
  // }

  Future<bool> addToFavorite(String jobId, int index,
      {ApiClient apiClient}) async {
    bool isSuccessful = await JobRepository().addToFavorite(jobId);
    if (isSuccessful) {
      jobListApplied[index].isFavourite = !jobListApplied[index].isFavourite;
      return isSuccessful;
    } else {
      return isSuccessful;
    }
  }
}

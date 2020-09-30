import 'package:get/get.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:dartz/dartz.dart' as dartZ;
import 'package:p7app/features/job/repositories/job_repository.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class JobDetailsViewModel extends GetxController {
  var jobModel = JobModel().obs;
  var isLoading = false.obs;
  var appError = AppError.none.obs;

  Future<bool> getJobDetails(String slug) async {
    isLoading.value = true;
    dartZ.Either<AppError, JobModel> result =
        await JobRepository().fetchJobDetails(slug);
    return result.fold((l) {
      isLoading.value = false;
      appError.value = l;
      logger.i(l);
      return false;
    }, (JobModel dataModel) {
      logger.i(dataModel.title);
      appError.value = AppError.none;
      jobModel.value = dataModel;
      isLoading.value = false;
      return true;
    });
  }

  get shouldShowLoading => jobModel.value?.jobId == null && isLoading.value;

  get shouldShowAppError =>
      jobModel.value.jobId == null && appError.value != AppError.none;
}

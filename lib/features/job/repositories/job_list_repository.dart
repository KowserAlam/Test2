import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/error.dart';

class JobListRepository {
  int count;
  bool next;

  Future<Either<AppError, List<JobModel>>> fetchJobList(
      {int page = 1, int size = 15}) async {
    try {
      var response = await ApiClient().getRequest(Urls.jobListUrl+"?page=$page&page_size=$size");
      print(response.statusCode);
      if (response.statusCode == 200) {
        var mapData  = json.decode(response.body);
        var jobList = fromJson(mapData);
        return Right(jobList);
      } else {
        return Left(AppError.serverError);
      }
    } catch (e){
      print(e);
      return Left(AppError.serverError);
    }
  }

  List<JobModel> fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next_pages'];
    List<JobModel>    jobList = new List<JobModel>();
    if (json['results'] != null) {
      json['results'].forEach((v) {
        jobList.add(new JobModel.fromJson(v));
      });
    }

    return jobList;
  }
}
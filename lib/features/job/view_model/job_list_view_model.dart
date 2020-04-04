
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/features/job/repositories/job_list_repository.dart';
import 'package:p7app/main_app/failure/error.dart';

class JobListViewModel with ChangeNotifier{
  List<JobModel> _jobList =[];

  List<JobModel> get jobList => _jobList;

  set jobList(List<JobModel> value) {
    _jobList = value;
    notifyListeners();
  }

  getJobList()async{
    Either<AppError,List<JobModel>> result = await JobListRepository().fetchJobList();
    result.fold((l) {
      print(l);
    }, (List<JobModel> list) {
      _jobList = list;
      notifyListeners();
    });
  }


}
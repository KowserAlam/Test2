


import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/features/job/repositories/job_list_repository.dart';
import 'package:p7app/main_app/failure/error.dart';

class JobListViewModel with ChangeNotifier{
  List<JobModel> _jobList =[];
  List<JobModel> get jobList => _jobList;

  bool _isFetchingData = false;
  bool _hasMoreData = false;
  int _pageCount = 1;
  JobListRepository _jobListRepository = JobListRepository();



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

  void incrementPageCount() {
    _pageCount++;
  }

  void resetPageCounter() {
    _pageCount = 1;
  }

  getJobList()async{
    isFetchingData = true;
    Either<AppError,List<JobModel>> result = await _jobListRepository.fetchJobList();
    result.fold((l) {
      isFetchingData = false;
      _checkHasMoreData();
      print(l);
    }, (List<JobModel> list) {
      isFetchingData = false;
      _jobList = list;
      notifyListeners();
      _checkHasMoreData();
    });
  }

  getMoreData()async{
    isFetchingData = true;
    debugPrint('Getting more jobs');
    hasMoreData = true;
    incrementPageCount();
    Either<AppError,List<JobModel>> result = await _jobListRepository.fetchJobList(page: _pageCount);
    result.fold((l) {
      isFetchingData = false;
      _checkHasMoreData();
      print(l);
    }, (List<JobModel> list) {

      _jobList.addAll(list);
      _isFetchingData = false;
      _checkHasMoreData();
    });
  }

  _checkHasMoreData(){
    if(_jobListRepository.next == null){
      hasMoreData = false;
    }else{
      hasMoreData = true;
    }
  }
  
  



}
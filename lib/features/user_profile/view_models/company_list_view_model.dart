import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/features/job/repositories/job_details_repository.dart';
import 'package:p7app/features/user_profile/models/company.dart';
import 'package:p7app/features/user_profile/repositories/company_list_repository.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/error.dart';

class CompanyListViewModel with ChangeNotifier{
  List<Company> companyList;
  bool isFetchingData;
  CompanyListRepository _companyListRepository = CompanyListRepository();
  String _query;

  set query(String value){
    _query = value;
  }


  Future<bool> getJobDetails() async {
    isFetchingData = true;


    Either<AppError, List<Company>> result =
    await _companyListRepository.getList(query: _query);
    return result.fold((l) {
      isFetchingData = false;
      print(l);
      return false;
    }, (List<Company> dataModel) {
      print(dataModel.length);
      companyList = dataModel;
      isFetchingData = false;
      notifyListeners();
      return true;
    });
  }

//  Future<bool> applyForJob(String jobId, int index,
//      {ApiClient apiClient}) async {
//    BotToast.showLoading();
//    var userId =
//    await AuthService.getInstance().then((value) => value.getUser().userId);
//    var body = {'user_id': userId, 'job_id': jobId};
//
//    try {
//      ApiClient client = apiClient ?? ApiClient();
//      var res = await client.postRequest(Urls.applyJobOnlineUrl, body);
//      print(res.body);
//
//      if (res.statusCode == 200) {
//        BotToast.closeAllLoading();
//        BotToast.showText(
//            text: StringUtils.successfullyAppliedText,
//            duration: Duration(seconds: 2));
//        _jobList[index].isApplied = true;
//        notifyListeners();
//        return true;
//      } else {
//        BotToast.closeAllLoading();
//        BotToast.showText(text: StringUtils.unableToSaveData);
//        return false;
//      }
//    } catch (e) {
//      BotToast.closeAllLoading();
//      BotToast.showText(text: StringUtils.unableToSaveData);
//      print(e);
//
//      return false;
//    }
//  }
//
//  Future<bool> addToFavorite(String jobId, int index,
//      {ApiClient apiClient}) async {
//    BotToast.showLoading();
//    var userId =
//    await AuthService.getInstance().then((value) => value.getUser().userId);
//    var body = {'user_id': userId, 'job_id': jobId};
//
//    try {
//      ApiClient client = apiClient ?? ApiClient();
//      var res = await client.postRequest(Urls.favouriteJobAddUrl, body);
//      print(res.body);
//
//      if (res.statusCode == 200) {
//        BotToast.closeAllLoading();
//
//        _jobList[index].status = !_jobList[index].status;
//        notifyListeners();
//        return true;
//      } else {
//        BotToast.closeAllLoading();
//        BotToast.showText(text: StringUtils.unableToSaveData);
//        return false;
//      }
//    } catch (e) {
//      BotToast.closeAllLoading();
//      BotToast.showText(text: StringUtils.unableToSaveData);
//      print(e);
//
//      return false;
//    }
//  }

  resetState() {
    companyList = null;
    isFetchingData = false;
    _companyListRepository = CompanyListRepository();
    notifyListeners();
  }
}
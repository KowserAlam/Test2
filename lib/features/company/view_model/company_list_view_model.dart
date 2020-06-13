import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/features/company/models/company.dart';
import 'package:p7app/features/company/repositories/company_list_repository.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/util/method_extension.dart';

class CompanyListViewModel with ChangeNotifier {
  List<Company> companyList;
  bool isFetchingData = false;
  CompanyListRepository _companyListRepository = CompanyListRepository();
  String _query;
  int noOfSearchResults = 0;
  bool isInSearchMode = false;

  set query(String value) {
    _query = value;
    notifyListeners();
  }

  bool get shouldShowCompanyCount =>
      _query.isNotEmptyOrNotNull && isInSearchMode  && !isFetchingData;

  bool get shouldShowLoader => isFetchingData && companyList == null;

  Future<bool> getCompanyList() async {
    if (_query.isNotEmptyOrNotNull) {
      companyList = null;
    }
    isFetchingData = true;
    notifyListeners();
    var limit = _query.isNotEmptyOrNotNull ? (_query.length > 2 ? 100 : 8) : 8;
    Either<AppError, List<Company>> result =
        await _companyListRepository.getList(query: _query, limit: limit);
    return result.fold((l) {
      isFetchingData = false;
      print(l);
      return false;
    }, (List<Company> dataModel) {
      print(dataModel.length);
      noOfSearchResults = dataModel.length;
      companyList = dataModel;
      isFetchingData = false;
      notifyListeners();
      return true;
    });
  }

  getMoreData() {

  }

  toggleIsInSearchMode() {
    isInSearchMode = !isInSearchMode;

    if (!isInSearchMode) {
      _query = null;
      getCompanyList();
    }
    notifyListeners();
  }

  clearSearch() {
    isFetchingData = false;
    isInSearchMode = false;
    _query = "";
  }

  resetState() {
    companyList = null;
    isFetchingData = false;
    isInSearchMode = false;
    _companyListRepository = CompanyListRepository();
    noOfSearchResults = 0;
    _query = "";
    getCompanyList();
    notifyListeners();
  }
}

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/features/company/models/company.dart';
import 'package:p7app/features/company/models/company_screen_data_model.dart';
import 'package:p7app/features/company/repositories/company_list_repository.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/method_extension.dart';

class CompanyListViewModel with ChangeNotifier {
  List<Company> companyList = [];
  bool _isFetchingData = false;
  bool _isFetchingMoreData = false;
  String _query;
  int _companiesCount = 0;
  bool isInSearchMode = false;
  bool _hasMoreData= false;
  int _page = 1;
  AppError _appError;

  AppError get appError => _appError;

  set query(String value) {
    _query = value;
    notifyListeners();
  }

  bool get shouldShowAppError => companyList.length == 0 && _appError != null;

  bool get shouldShowCompanyCount =>
      _query.isNotEmptyOrNotNull && isInSearchMode && !_isFetchingData;

  bool get shouldShowLoader => _isFetchingData && companyList.length == 0;

  Future<bool> getCompanyList() async {
    if (_query.isNotEmptyOrNotNull) {
      companyList = [];
    }
    _appError = null;
    _isFetchingData = true;
    notifyListeners();
    Either<AppError, CompanyScreenDataModel> result =
        await CompanyListRepository().getList(query: _query);
    return result.fold((l) {
      _isFetchingData = false;
      print(l);
      _appError = l;
      notifyListeners();
      return false;
    }, (CompanyScreenDataModel dataModel) {
      var list = dataModel.companies;
      print(list.length);
      _companiesCount = dataModel.count;
      companyList = list;
      _isFetchingData = false;
      _hasMoreData = dataModel.next;
      notifyListeners();
      return true;
    });
  }

  getMoreData() async {
    debugPrint("Getting more data");
    debugPrint(_hasMoreData.toString());

    if (_hasMoreData && !_isFetchingMoreData && !_isFetchingData) {
      _appError = null;
      debugPrint("Getting more data");
      _page++;
      _isFetchingMoreData = true;
      notifyListeners();

      Either<AppError, CompanyScreenDataModel> result =
          await CompanyListRepository().getList(query: _query, page: _page);
      return result.fold((l) {
        _isFetchingMoreData = false;
        _appError = l;
        notifyListeners();
        print(l);
        return false;
      }, (CompanyScreenDataModel dataModel) {
        _companiesCount = dataModel.count;
        companyList.addAll(dataModel.companies);
        _isFetchingMoreData = false;
        _hasMoreData = dataModel.next;
        notifyListeners();
        return true;
      });
    }
  }

  toggleIsInSearchMode() {
    isInSearchMode = !isInSearchMode;
    _page = 1;
    if (!isInSearchMode) {
      _query = null;
      getCompanyList();
    }
    notifyListeners();
  }

  clearSearch() {
    _page = 1;
    _isFetchingData = false;
    _isFetchingMoreData = false;
    isInSearchMode = false;
    _query = "";
  }

  Future<void> refresh() async {
    _page = 0;
    return getCompanyList();
  }

  resetState() {
    companyList = null;
    _isFetchingData = false;
    _isFetchingMoreData = false;
    isInSearchMode = false;
    _companiesCount = 0;
    _query = "";
    _page = 1;
    getCompanyList();
    notifyListeners();
  }

  bool get hasMoreData => _hasMoreData;

  bool get isFetchingData => _isFetchingData;

  int get companiesCount => _companiesCount;

  bool get isFetchingMoreData => _isFetchingMoreData;
}

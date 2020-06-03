import 'package:flutter/cupertino.dart';
import 'package:p7app/features/career_advice/models/career_advice_model.dart';
import 'package:p7app/features/career_advice/models/career_advice_screen_data_model.dart';
import 'package:p7app/features/career_advice/repositories/c_a_repository.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/const.dart';

class CareerAdviceViewModel with ChangeNotifier {
//  CareerAdviceScreenDataModel _careerAdviceScreenDataModel;
  List<CareerAdviceModel> _careerAdviceList =[];

  AppError _appError;
  DateTime _lastFetchTime;
  bool _isFetchingMoreData = false;
  bool _isFetchingData = false;
  int _page = 1;
  bool _hasMoreData = true;

  resetPageCounter(){
    _page = 0;
  }

  Future<void> refresh(){
    _page = 0;
   return getData();
  }

  Future<void> getData({bool isFromOnPageLoad = false}) async {
    if (isFromOnPageLoad) {
      if (_lastFetchTime != null) if (_lastFetchTime
              .difference(DateTime.now()) <
          kDefaultTimeToPreventAutoRefresh) return;
    }
    _isFetchingData = true;
    _lastFetchTime = DateTime.now();
    notifyListeners();
    var res = await CareerAdviceRepository().getData();

    res.fold((l) {
      _appError = l;
      _isFetchingData = false;
      _hasMoreData = false;
      notifyListeners();
    }, (r) {
      _careerAdviceList = r.careerAdviceList;
      _isFetchingData = false;
      _hasMoreData = r.nextPages;
      notifyListeners();
    });
  }

  getMoreData() async {
    _isFetchingMoreData = true;
    notifyListeners();
    var res = await CareerAdviceRepository().getData();

    res.fold((l) {
      _appError = l;
      _isFetchingMoreData = false;
      _hasMoreData = false;
      notifyListeners();
    }, (r) {
      _isFetchingMoreData = false;
      _careerAdviceList.addAll(r.careerAdviceList);
      _hasMoreData = r.nextPages;
      notifyListeners();
    });
  }

  AppError get appError => _appError;



  bool get isFetchingData => _isFetchingData;

  bool get isFetchingMoreData => _isFetchingMoreData;

  bool get hasMoreData => _hasMoreData;

  bool get shouldFetchMoreData =>
      _hasMoreData && !_isFetchingData && !_isFetchingMoreData;

  bool get shouldShowPageLoader =>
      _isFetchingData && _careerAdviceList.length == 0;


  List<CareerAdviceModel> get careerAdviceList => _careerAdviceList;
}

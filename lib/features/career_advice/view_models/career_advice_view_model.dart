import 'package:flutter/cupertino.dart';
import 'package:p7app/features/career_advice/models/career_advice_model.dart';
import 'package:p7app/features/career_advice/models/career_advice_screen_data_model.dart';
import 'package:p7app/features/career_advice/repositories/c_a_repository.dart';
import 'package:p7app/main_app/failure/app_error.dart';

class CareerAdviceViewModel with ChangeNotifier {
  CareerAdviceScreenDataModel _careerAdviceScreenDataModel;
  AppError _appError;
  DateTime _lastFetchTime;

  getData() async {
    _lastFetchTime = DateTime.now();
    var res = await CareerAdviceRepository().getData();

    res.fold((l) {
      _appError = l;
      notifyListeners();
    }, (r) {
      _careerAdviceScreenDataModel = r;
      notifyListeners();
    });
  }

  AppError get appError => _appError;

  CareerAdviceScreenDataModel get careerAdviceScreenDataModel =>
      _careerAdviceScreenDataModel;
}

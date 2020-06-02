

import 'package:flutter/foundation.dart';
import 'package:p7app/features/dashboard/models/info_box_data_model.dart';
import 'package:p7app/features/dashboard/models/skill_job_chart_data_model.dart';
import 'package:p7app/features/dashboard/repositories/dashboard_repository.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/util/common_serviec_rule.dart';

class DashboardViewModel with ChangeNotifier {
  AppError _infoBoxError;
  AppError _skillJobChartError;
  InfoBoxDataModel _infoBoxData;
  List<SkillJobChartDataModel> _skillJobChartData =[];
  bool _isLoadingInfoBoxData = false;
  bool _isLoadingSkillJobChartData = false;
  bool _idExpandedSkillList = false;
  DateTime _lastFetchTime;





  Future <void> getDashboardData({bool isFormOnPageLoad = false}) async{
    var time = Duration(minutes: 5);
    if(isFormOnPageLoad)
      if(_lastFetchTime != null){
        if(_lastFetchTime.difference(DateTime.now()) < time)
          return false;
      }

    _lastFetchTime = DateTime.now();
    _isLoadingInfoBoxData = true;
     _isLoadingSkillJobChartData = true;
    notifyListeners();
    return Future.wait([
    _getInfoBoxData(),
    _getISkillJobChartData(),
    ]);

  }
  Future<bool> _getInfoBoxData() async {
    var result = await DashBoardRepository().getInfoBoxData();

   return result.fold((l) {
      _infoBoxError =l;
      _isLoadingInfoBoxData = false;
      notifyListeners();
      return false;
    }, (r){
      _infoBoxData =r;
      _isLoadingInfoBoxData = false;
      notifyListeners();
      return true;
    });
  }
  Future<bool> _getISkillJobChartData() async {
    var result = await DashBoardRepository().getSkillJobChart();

    return result.fold((l) {
      _skillJobChartError =l;
      _isLoadingSkillJobChartData = false;
      notifyListeners();
      return false;
    }, (r){
      _skillJobChartData =r;
      _isLoadingSkillJobChartData = false;
      notifyListeners();
      return true;
    });
  }
  bool get shouldShowInfoBoxLoader => _isLoadingInfoBoxData && (_infoBoxData == null);
  bool get shouldShowJoChartLoader => _isLoadingSkillJobChartData && (_skillJobChartData.length == 0);
  AppError get infoBoxError => _infoBoxError;
  AppError get skillJobChartError => _skillJobChartError;

  InfoBoxDataModel get infoBoxData => _infoBoxData;

  List<SkillJobChartDataModel> get skillJobChartData => _skillJobChartData;

  bool get isLoadingInfoBoxData => _isLoadingInfoBoxData;

  bool get isLoadingSkillJobChartData => _isLoadingSkillJobChartData;

  bool get idExpandedSkillList => _idExpandedSkillList;

  set idExpandedSkillList(bool value) {
    _idExpandedSkillList = value;
    notifyListeners();
  }
}

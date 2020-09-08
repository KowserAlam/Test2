import 'package:flutter/foundation.dart';
import 'package:p7app/features/auth/view/sign_in_screen.dart';
import 'package:p7app/features/dashboard/models/info_box_data_model.dart';
import 'package:p7app/features/dashboard/models/skill_job_chart_data_model.dart';
import 'package:p7app/features/dashboard/models/top_categories_model.dart';
import 'package:p7app/features/dashboard/models/vital_stats_data_model.dart';
import 'package:p7app/features/dashboard/repositories/dashboard_repository.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/util/common_serviec_rule.dart';

class DashboardViewModel with ChangeNotifier {
  AppError _infoBoxError;
  AppError _skillJobChartError;
  AppError _vitalStateError;
  AppError _topCategoriesError;

  InfoBoxDataModel _infoBoxData;
  VitalStatsDataModel _vitalStatsData;
  List<SkillJobChartDataModel> _skillJobChartData = [];
  List<TopCategoriesModel> _topCategoryList = [];

  bool _isLoadingInfoBoxData = false;
  bool _isLoadingSkillJobChartData = false;
  bool _isLoadingVitalState = false;
  bool _isLoadingTopCategories = false;
  bool _idExpandedSkillList = false;
  DateTime _lastFetchTime;
  double profileCompletePercent = 0;

  Future<AppError> getDashboardData({bool isFormOnPageLoad = false}) async {
    bool loggedIn = await  AuthService.getInstance().then((value) => value.isAccessTokenValid());
    if (isFormOnPageLoad) {
      bool shouldNotFetchData = CommonServiceRule.instance
          .shouldNotFetchData(_lastFetchTime, _infoBoxError);
      if (shouldNotFetchData) return null;
    }

    _isLoadingInfoBoxData = true;
    _isLoadingSkillJobChartData = true;
    _infoBoxError = null;
    _skillJobChartError = null;
    notifyListeners();
    return Future.wait([

      if(loggedIn)
      _getInfoBoxData(),
      if(loggedIn)
      _getISkillJobChartData(),
      if(loggedIn)
      _getProfileCompleteness(),
      
      _getVitalStats(),
      _getTopCategories(),
    ]).then((value) {
      _lastFetchTime = DateTime.now();
      return _infoBoxError;
    });
  }

  Future<bool> _getInfoBoxData() async {
    var result = await DashBoardRepository().getInfoBoxData();

    return result.fold((l) {
      _infoBoxError = l;
      _isLoadingInfoBoxData = false;
      notifyListeners();
      return false;
    }, (r) {
      _infoBoxData = r;
      _isLoadingInfoBoxData = false;
      notifyListeners();
      return true;
    });
  }

  Future<bool> _getISkillJobChartData() async {
    var result = await DashBoardRepository().getSkillJobChart();

    return result.fold((l) {
      _skillJobChartError = l;
      _isLoadingSkillJobChartData = false;
      notifyListeners();
      return false;
    }, (r) {
      _skillJobChartData = r;
      _isLoadingSkillJobChartData = false;
      notifyListeners();
      return true;
    });
  }

  Future<double> _getProfileCompleteness() async {
    return DashBoardRepository().getProfileCompletenessPercent().then((value) {
      notifyListeners();
      return profileCompletePercent = value;
    });
  }

  Future<bool> _getVitalStats() async {
    var result = await DashBoardRepository().getVitalStats();

    return result.fold((l) {
      _vitalStateError = l;
      _isLoadingVitalState = false;
      notifyListeners();
      return false;
    }, (r) {
      _vitalStatsData = r;
      _isLoadingVitalState = false;
      notifyListeners();
      return true;
    });
  }

  Future<bool> _getTopCategories() async {
    var result = await DashBoardRepository().getTopCategories();

    return result.fold((l) {
      _topCategoriesError = l;
      _isLoadingTopCategories = false;
      notifyListeners();
      return false;
    }, (r) {
      _topCategoryList = r;
      _isLoadingTopCategories = false;
      notifyListeners();
      return true;
    });
  }

  bool get shouldShowInfoBoxLoader =>
      _isLoadingInfoBoxData && (_infoBoxData == null);

  bool get shouldShowJoChartLoader =>
      _isLoadingSkillJobChartData && (_skillJobChartData.length == 0);

  AppError get infoBoxError => _infoBoxError;

  AppError get skillJobChartError => _skillJobChartError;

  InfoBoxDataModel get infoBoxData => _infoBoxData;

  List<SkillJobChartDataModel> get skillJobChartData => _skillJobChartData;

  bool get isLoadingInfoBoxData => _isLoadingInfoBoxData;

  bool get isLoadingSkillJobChartData => _isLoadingSkillJobChartData;

  bool get idExpandedSkillList => _idExpandedSkillList;

  bool get shouldShowError => _infoBoxError != null && infoBoxData == null;

  bool get showProfileCompletePercentIndicatorWidget =>
      profileCompletePercent != 100;

  set idExpandedSkillList(bool value) {
    _idExpandedSkillList = value;
    notifyListeners();
  }

  bool get isLoadingVitalState => _isLoadingVitalState;

  VitalStatsDataModel get vitalStatsData => _vitalStatsData;

  AppError get vitalStateError => _vitalStateError;

  bool get isLoadingTopCategories => _isLoadingTopCategories;

  List<TopCategoriesModel> get topCategoryList => _topCategoryList;

  AppError get topCategoriesError => _topCategoriesError;
}

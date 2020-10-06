import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:p7app/features/auth/view/sign_in_screen.dart';
import 'package:p7app/features/company/models/company.dart';
import 'package:p7app/features/dashboard/models/info_box_data_model.dart';
import 'package:p7app/features/dashboard/models/skill_job_chart_data_model.dart';
import 'package:p7app/features/dashboard/models/top_categories_model.dart';
import 'package:p7app/features/dashboard/models/vital_stats_data_model.dart';
import 'package:p7app/features/dashboard/repositories/dashboard_repository.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/util/common_serviec_rule.dart';

class DashboardViewModel extends GetxController {
  AppError _infoBoxError;
  AppError _skillJobChartError;
  AppError _vitalStateError;
  AppError _topCategoriesError;
  AppError _recentJobsError;
  AppError _featureCompaniesError;

  InfoBoxDataModel _infoBoxData;
  VitalStatsDataModel _vitalStatsData;
  List<SkillJobChartDataModel> _skillJobChartData = [];
  List<TopCategoriesModel> _topCategoryList = [];
  List<JobListModel> _recentJobsList = [];
  List<Company> _featuredCompanies = [];

  bool _isLoadingInfoBoxData = false;
  bool _isLoadingSkillJobChartData = false;
  bool _isLoadingVitalState = false;
  bool _isLoadingTopCategories = false;
  bool _isLoadingRecentJobs = false;
  bool _isLoadingFeatureCompanies = false;
  bool _idExpandedSkillList = false;
  double profileCompletePercent = 0;

  Future<AppError> getDashboardData() async {
    bool loggedIn = await  AuthService.getInstance().then((value) => value.isAccessTokenValid());


    _isLoadingInfoBoxData = true;
    _isLoadingSkillJobChartData = true;
    _infoBoxError = null;
    _skillJobChartError = null;
    update();
    return Future.wait([

      if(loggedIn)
      _getInfoBoxData(),
      if(loggedIn)
      _getISkillJobChartData(),
      if(loggedIn)
      getProfileCompleteness(),

      _getVitalStats(),
      _getTopCategories(),
      _getRecentJobs(),
      _getFeaturedCompanies(),
    ]).then((value) {
      return _infoBoxError;
    });
  }

  Future<bool> _getInfoBoxData() async {
    var result = await DashBoardRepository().getInfoBoxData();

    return result.fold((l) {
      _infoBoxError = l;
      _isLoadingInfoBoxData = false;
      update();
      return false;
    }, (r) {
      _infoBoxData = r;
      _isLoadingInfoBoxData = false;
      update();
      return true;
    });
  }

  Future<bool> _getISkillJobChartData() async {
    var result = await DashBoardRepository().getSkillJobChart();

    return result.fold((l) {
      _skillJobChartError = l;
      _isLoadingSkillJobChartData = false;
      update();
      return false;
    }, (r) {
      _skillJobChartData = r;
      _isLoadingSkillJobChartData = false;
      update();
      return true;
    });
  }

  Future<double> getProfileCompleteness() async {
    return DashBoardRepository().getProfileCompletenessPercent().then((value) {

       profileCompletePercent = value;
       update();
      return value;
    });
  }

  Future<bool> _getVitalStats() async {
    var result = await DashBoardRepository().getVitalStats();

    return result.fold((l) {
      _vitalStateError = l;
      _isLoadingVitalState = false;
      update();
      return false;
    }, (r) {
      _vitalStatsData = r;
      _isLoadingVitalState = false;
      update();
      return true;
    });
  }

  Future<bool> _getTopCategories() async {
    var result = await DashBoardRepository().getTopCategories();

    return result.fold((l) {
      _topCategoriesError = l;
      _isLoadingTopCategories = false;
      update();
      return false;
    }, (r) {
      _topCategoryList = r;
      _isLoadingTopCategories = false;
      update();
      return true;
    });
  }

  Future<bool> _getRecentJobs() async {
    var result = await DashBoardRepository().getRecentJobs();

    return result.fold((l) {
      _recentJobsError = l;
      _isLoadingRecentJobs = false;
      update();
      return false;
    }, (r) {
      _recentJobsList = r;
      _isLoadingRecentJobs = false;
      update();
      return true;
    });
  }
  Future<bool> _getFeaturedCompanies() async {
    var result = await DashBoardRepository().getFeaturedCompanies();

    return result.fold((l) {
      _featureCompaniesError = l;
      _isLoadingFeatureCompanies = false;
      update();
      return false;
    }, (r) {
      _featuredCompanies = r;
      _isLoadingFeatureCompanies = false;
      update();
      return true;
    });
  }

  bool get shouldShowInfoBoxLoader =>
      _isLoadingInfoBoxData && (_infoBoxData == null);

  bool get shouldShowJoChartLoader =>
      _isLoadingSkillJobChartData && (_skillJobChartData.length == 0);

  bool get shouldShowFeaturedCompanyLoader =>
      _isLoadingFeatureCompanies && (_featuredCompanies.length == 0);

  bool get shouldShowRecentJobsLoader =>
      _isLoadingRecentJobs && (_recentJobsList.length == 0);

  bool get shouldShowTopCategoriesLoader =>
      _isLoadingTopCategories && (_topCategoryList.length == 0);

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
    update();
  }

  bool get isLoadingVitalState => _isLoadingVitalState;

  VitalStatsDataModel get vitalStatsData => _vitalStatsData;

  AppError get vitalStateError => _vitalStateError;

  bool get isLoadingTopCategories => _isLoadingTopCategories;

  bool get isLoadingRecentJobs => _isLoadingRecentJobs;

  List<TopCategoriesModel> get topCategoryList => _topCategoryList;

  List<JobListModel> get recebtJobsList => _recentJobsList;

  AppError get topCategoriesError => _topCategoriesError;

  AppError get recentJobsError => _recentJobsError;

  List<Company> get featuredCompanies => _featuredCompanies;
}

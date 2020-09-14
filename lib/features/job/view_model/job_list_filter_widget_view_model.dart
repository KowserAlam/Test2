import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/job/models/jon_type_model.dart';
import 'package:p7app/features/job/models/sort_item.dart';
import 'package:p7app/features/job/repositories/job_gender_list_repository.dart';
import 'package:p7app/features/job/repositories/job_list_sort_items_repository.dart';
import 'package:p7app/features/job/repositories/job_location_list_repository.dart';
import 'package:p7app/features/job/repositories/job_type_list_repository.dart';
import 'package:p7app/features/job/repositories/job_categories_list_repository.dart';
import 'package:p7app/main_app/models/skill.dart';
import 'package:p7app/features/user_profile/repositories/degree_list_repository.dart';
import 'package:p7app/features/user_profile/repositories/gender_list_repository.dart';
import 'package:p7app/main_app/repositories/skill_list_repository.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class JobListFilterWidgetViewModel with ChangeNotifier {
  List<Skill> _skills = [];
  List<String> _jobCity = [];
  List<String> _jobCategories = [];
  List<JobType> _jobTypes = [];
  List<String> _qualifications = [];
  List<String> _genders = [];
  String _selectedCategory;
  String _selectedLocation;
  JobType _selectedJobType;
  double _experienceMax;
  double _experienceMin;
  double _salaryMax;
  double _salaryMin;
  String _selectedGender;
  String _selectedQualification;
  Skill _selectedSkill;
  String _selectedDatePosted;
  SortItem _selectedSortBy;
  List<SortItem> sortByList = JobListSortItemRepository()
      .getList();
  
  List<String> datePostedList = [
    "Last hour",
    "Last 24 hour",
    "Last 7 days",
    "Last 14 days",
    "Last 30 days"
  ];


  SortItem get selectedSortBy => _selectedSortBy;

  set selectedSortBy(SortItem value) {
    _selectedSortBy = value;
    notifyListeners();
  }

  String get selectedDatePosted => _selectedDatePosted;

  set selectedDatePosted(String value) {
    _selectedDatePosted = value;
    notifyListeners();
  }

  List<String> get jobCity => _jobCity;

  set jobCity(List<String> value) {
    _jobCity = value;
    notifyListeners();
  }

  Skill get selectedSkill => _selectedSkill;

  set selectedSkill(Skill value) {
    _selectedSkill = value;
    notifyListeners();
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  String get selectedLocation => _selectedLocation;

  set selectedLocation(String value) {
    _selectedLocation = value;
    notifyListeners();
  }

  List<Skill> get skills => _skills;

  set skills(List<Skill> value) {
    _skills = value;
    notifyListeners();
  }

  JobType get selectedJobType => _selectedJobType;

  set selectedJobType(JobType value) {
    _selectedJobType = value;
    notifyListeners();
  }

  double get experienceMax => _experienceMax;

  set experienceMax(double value) {
    _experienceMax = value;
    notifyListeners();
  }

  double get experienceMin => _experienceMin;

  set experienceMin(double value) {
    _experienceMin = value;
    notifyListeners();
  }

  double get salaryMax => _salaryMax;

  set salaryMax(double value) {
    _salaryMax = value;
    notifyListeners();
  }

  double get salaryMin => _salaryMin;

  set salaryMin(double value) {
    _salaryMin = value;
    notifyListeners();
  }

  String get selectedGender => _selectedGender;

  set selectedGender(String value) {
    _selectedGender = value;
    notifyListeners();
  }

  String get selectedQualification => _selectedQualification;

  set selectedQualification(String value) {
    _selectedQualification = value;
    notifyListeners();
  }

  List<String> get jobCategories => _jobCategories;

  set jobCategories(List<String> value) {
    _jobCategories = value;
  }

  List<JobType> get jobTypes => _jobTypes;

  set jobTypes(List<JobType> value) {
    _jobTypes = value;
  }

  List<String> get qualifications => _qualifications;

  set qualifications(List<String> value) {
    _qualifications = value;
  }

  List<String> get genders => _genders;

  set genders(List<String> value) {
    _genders = value;
    notifyListeners();
  }

  ///*********************************
  /// Methods
  /// *******************************

  getAllFilters() async {
    skills = await _getSkillList();
    jobTypes = await _getJobTypeList();
    jobCategories = await _getJobCategoriesList();
    jobCity = await _getJobLocationList();
    qualifications = await _getQualificationList();
    genders = await _getGenderList();
  }

  Future<List<Skill>> _getSkillList() async {
    Either<AppError, List<Skill>> res =
        await SkillListRepository().getSkillList();
    return res.fold((l) {
      logger.i(l);
      return [];
    }, (r) => r);
  }

  Future<List<JobType>> _getJobTypeList() async {
    Either<AppError, List<JobType>> res = await JobTypeListRepository().getList();
    return res.fold((l) {
      logger.i(l);
      return [];
    }, (r) => r);
  }

  Future<List<String>> _getJobLocationList() async {
    Either<AppError, List<String>> res =
        await JobLocationListRepository().getList();
    return res.fold((l) {
      logger.i(l);
      return [];
    }, (r) => r);
  }

  Future<List<String>> _getJobCategoriesList() async {
    Either<AppError, List<String>> res =
        await JobCategoriesLisRepository().getList();
    return res.fold((l) {
      logger.i(l);
      return [];
    }, (r) => r);
  }

  Future<List<String>> _getQualificationList() async {
 List<String> res = await DegreeListRepository().getList();
    return res;
  }

  Future<List<String>> _getGenderList() async {
    Either<AppError, List<String>> res =
        await JobGenderListRepository().getGenderList();
    return res.fold((l) {
      logger.i(l);
      return [];
    }, (r) => r);
  }

  onchangeSalaryRange(RangeValues values) {
    _salaryMax = values.end;
    _salaryMin = values.start;
    notifyListeners();
  }

  onchangeExperienceRange(RangeValues values) {
    _experienceMax = values.end;
    _experienceMin = values.start;
    notifyListeners();
  }

  resetState() {
    _selectedGender = null;
    _selectedQualification = null;
    _selectedSkill = null;
    _selectedCategory = null;
    _selectedJobType = null;
    _selectedLocation = null;
    _salaryMin = null;
    _salaryMax = null;
    _experienceMin = null;
    _experienceMax = null;
    _selectedDatePosted = null;
    _selectedSortBy = null;
    getAllFilters();
    notifyListeners();
  }
}

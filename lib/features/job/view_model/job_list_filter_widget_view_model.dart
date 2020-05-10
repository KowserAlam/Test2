import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:p7app/features/user_profile/models/skill.dart';
import 'package:p7app/features/user_profile/repositories/skill_list_repository.dart';
import 'package:p7app/main_app/failure/error.dart';

class JobListFilterWidgetViewModel with ChangeNotifier {
  String _category;
  String _location;
  List<Skill> _skills =[];
  String _jobType;
  int _experienceMax;
  int _experienceMin;
  int _salaryMax;
  int _salaryMin;
  int _gender;
  int _qualification;

  Skill get selectedSkill => _selectedSkill;

  set selectedSkill(Skill value) {
    _selectedSkill = value;
    notifyListeners();
  }

  Skill _selectedSkill;

  String get category => _category;

  set category(String value) {
    _category = value;
    notifyListeners();
  }

  String get location => _location;

  set location(String value) {
    _location = value;
    notifyListeners();
  }

  List<Skill> get skills => _skills;

  set skills( List<Skill> value) {
    _skills = value;
    notifyListeners();
  }

  String get jobType => _jobType;

  set jobType(String value) {
    _jobType = value;
    notifyListeners();
  }

  int get experienceMax => _experienceMax;

  set experienceMax(int value) {
    _experienceMax = value;
    notifyListeners();
  }

  int get experienceMin => _experienceMin;

  set experienceMin(int value) {
    _experienceMin = value;
    notifyListeners();
  }

  int get salaryMax => _salaryMax;

  set salaryMax(int value) {
    _salaryMax = value;
    notifyListeners();
  }

  int get salaryMin => _salaryMin;

  set salaryMin(int value) {
    _salaryMin = value;
    notifyListeners();
  }

  int get gender => _gender;

  set gender(int value) {
    _gender = value;
    notifyListeners();
  }

  int get qualification => _qualification;

  set qualification(int value) {
    _qualification = value;
    notifyListeners();
  }

  getAllFilters() async {
    skills = await _getSkillList();
  }

  Future<List<Skill>> _getSkillList() async {
    Either<AppError, List<Skill>> res =
        await SkillListRepository().getSkillList();
    return res.fold((l) {
      print(l);
      return [];
    }, (r) => r);
  }

}

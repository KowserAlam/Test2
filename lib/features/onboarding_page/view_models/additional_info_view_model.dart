import 'dart:math';

import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/skill.dart';
import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/main_app/repositories/job_experience_list_repository.dart';
import 'package:p7app/main_app/repositories/skill_list_repository.dart';

class AdditionalInfoViewModel with ChangeNotifier {
  var jobSeekingStatusList = <String>[
    "Yes, I'm actively looking",
    "I'm not looking, but open to opportunities",
    "Just exploring",
  ];

  List<SkillInfo> _selectedSkills = [];
  List<Skill> skillList = [];
  List<String> experienceList = [];
  String _radioValue; //
  String _selectedExperience;

  void onJobSeekingRadioButtonChanges(String value) {
    _radioValue = value;
    notifyListeners();
  }

  getData() {
    _getExpList();
    _getSkillList();
  }

  Future<void> addSkill(SkillInfo skillInfo) async {
    _selectedSkills.add(skillInfo);
    notifyListeners();
    return;
  }

  removeSkill(int id) {
    _selectedSkills.removeWhere((element) => element.profSkillId == id);
    notifyListeners();
  }

  _getExpList() {
    JobExperienceListRepository().getList().then((value) {
      experienceList = value.fold((l) => [], (r) => r);
      notifyListeners();
    });
  }

  _getSkillList() {
    SkillListRepository().getSkillList().then((value) {
      skillList = value.fold((l) => [], (r) => r);
      notifyListeners();
    });
  }

  String get selectedExperience => _selectedExperience;

  set selectedExperience(String value) {
    _selectedExperience = value;
  }

  String get radioValue => _radioValue;

  set radioValue(String value) {
    _radioValue = value;
  }

  List<SkillInfo> get selectedSkills => _selectedSkills;
}

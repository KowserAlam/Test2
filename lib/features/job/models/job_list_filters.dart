import 'package:p7app/features/job/models/jon_type_model.dart';
import 'package:p7app/features/job/models/sort_item.dart';
import 'package:p7app/features/user_profile/models/skill.dart';

class JobListFilters {
  int page;
  int page_size;
  String searchQuery;
  String location;
  String category;
  String location_from_homepage;
  String keyword_from_homepage;
  Skill skill;
  String salaryMin;
  String salaryMax;
  String experienceMin;
  String experienceMax;
  String datePosted;
  String gender;
  String qualification;
  SortItem sort;
  bool isApplied;
  JobType jobType;
  String topSkill;
  String jobCity;

  JobListFilters({
    this.page = 1,
    this.page_size = 15,
    this.searchQuery,
    this.location,
    this.category,
    this.location_from_homepage = '',
    this.keyword_from_homepage = '',
    this.skill,
    this.salaryMin,
    this.salaryMax,
    this.experienceMin,
    this.experienceMax,
    this.datePosted,
    this.gender,
    this.qualification,
    this.sort,
    this.isApplied,
    this.jobType,
    this.topSkill,
    this.jobCity,
  });
}

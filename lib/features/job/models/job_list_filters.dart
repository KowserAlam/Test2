import 'package:p7app/features/job/models/sort_item.dart';

class JobListFilters {
  int page;
  int page_size;
  String searchQuery;
  String location;
  String category;
  String location_from_homepage;
  String keyword_from_homepage;
  String skill;
  String salaryMin;
  String salaryMax;
  String experienceMin;
  String experienceMax;
  String datePosted;
  String gender;
  String qualification;
  SortItem sort;
  bool isApplied;

  JobListFilters({
    this.page = 1,
    this.page_size = 15,
    this.searchQuery = '',
    this.location = '',
    this.category = '',
    this.location_from_homepage = '',
    this.keyword_from_homepage = '',
    this.skill = '',
    this.salaryMin = '',
    this.salaryMax = '',
    this.experienceMin = '',
    this.experienceMax = '',
    this.datePosted = '',
    this.gender = '',
    this.qualification = '',
    this.sort,
    this.isApplied,
  });
}

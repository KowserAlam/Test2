import 'package:flutter/material.dart';
import 'package:p7app/features/job/view_model/job_list_filter_widget_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:provider/provider.dart';
import 'package:p7app/method_extension.dart';

class FilterPreviewWidget extends StatelessWidget {
  Widget filterItem(
      {@required String name,
      @required String value,
      BuildContext context,
      Function onClear}) {
    return Container(
        margin: EdgeInsets.only(left: 2, right: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.2)),
            boxShadow: CommonStyle.boxShadow,
            color: Theme.of(context).backgroundColor),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: "${name ?? ""} : ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: value ?? "",
                )
              ])),
            ),
            SizedBox(
              width: 2,
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                  onTap: onClear,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red[100]),
                          child: Icon(
                            Icons.clear,
                            size: 17,
                            color: Colors.red,
                          )),
                    ),
                  )),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    var jobListFilterWidgetViewModel =
        Provider.of<JobListFilterWidgetViewModel>(context);
    return Consumer<JobListViewModel>(builder: (context, jobListViewModel, _) {
      var filters = jobListViewModel.jobListFilters;
      return Container(
        height: 36,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200])),
          color: backgroundColor,
boxShadow: CommonStyle.boxShadow
//          boxShadow: [
//            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
//            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
//          ],
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            if (jobListViewModel.hasSortBy)
              filterItem(
                  context: context,
                  name: StringResources.sortBy,
                  value: filters.sort?.value,
                  onClear: () {
                    jobListViewModel.clearSort();
                    jobListFilterWidgetViewModel.selectedSortBy = null;
                  }),
            if (jobListViewModel.hasCategory)
              filterItem(
                  context: context,
                  name: StringResources.jobCategoryText,
                  value: filters.category.replaceAmpWith26,
                  onClear: () {
                    jobListViewModel.clearCategory();
                    jobListFilterWidgetViewModel.selectedCategory = null;
                  }),
            if (jobListViewModel.hasLocation)
              filterItem(
                  context: context,
                  name: StringResources.locationText,
                  value: filters.location,
                  onClear: () {
                    jobListViewModel.clearLocation();
                    jobListFilterWidgetViewModel.selectedLocation = null;
                  }),
            if (jobListViewModel.hasSkill)
              filterItem(
                  value: filters.skill.name,
                  context: context,
                  name: StringResources.skillText,
                  onClear: () {
                    jobListViewModel.clearSkill();
                    jobListFilterWidgetViewModel.selectedSkill = null;
                  }),
            if (jobListViewModel.hasExperienceRange)
              filterItem(
                  context: context,
                  name: StringResources.experienceText,
                  value: "${filters.experienceMin} - ${filters.experienceMax}",
                  onClear: () {
                    jobListViewModel.clearExperienceRange();
                    jobListFilterWidgetViewModel.experienceMin = null;
                    jobListFilterWidgetViewModel.experienceMax = null;
                  }),
            if (jobListViewModel.hasJobType)
              filterItem(
                  context: context,
                  name: StringResources.jobTypeText,
                  value: filters.jobType?.name,
                  onClear: () {
                    jobListViewModel.clearJobType();
                    jobListFilterWidgetViewModel.selectedJobType = null;
                  }),
            if (jobListViewModel.hasSalaryRange)
              filterItem(
                  context: context,
                  name: StringResources.salaryRangeText,
                  value: "${filters.salaryMin} - ${filters.salaryMax}",
                  onClear: () {
                    jobListViewModel.clearSalaryRange();
                    jobListFilterWidgetViewModel.salaryMin = null;
                    jobListFilterWidgetViewModel.salaryMax = null;
                  }),
            if (jobListViewModel.hasQualification)
              filterItem(
                  context: context,
                  value: filters.qualification,
                  name: StringResources.qualificationText,
                  onClear: () {
                    jobListViewModel.clearQualification();
                    jobListFilterWidgetViewModel.selectedQualification = null;
                  }),
            if (jobListViewModel.hasGender)
              filterItem(
                  context: context,
                  name: StringResources.genderText,
                  value: filters.gender,
                  onClear: () {
                    jobListViewModel.clearGender();
                    jobListFilterWidgetViewModel.selectedGender = null;
                  }),
            if (jobListViewModel.hasDatePosted)
              filterItem(
                  context: context,
                  name: StringResources.datePosted,
                  value: filters.datePosted,
                  onClear: () {
                    jobListViewModel.clearDatePosted();
                    jobListFilterWidgetViewModel.selectedDatePosted = null;
                  }),
          ],
        ),
      );
    });
  }
}

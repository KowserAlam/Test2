import 'package:flutter/material.dart';
import 'package:p7app/features/job/view_model/job_list_filter_widget_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:provider/provider.dart';

class FilterPreviewWidget extends StatelessWidget {
  Widget filterItem(
      {@required String label, BuildContext context, Function onClear}) {
    return Container(
        margin: EdgeInsets.only(left: 2, right: 2),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.2)),
            boxShadow: CommonStyleTextField.boxShadow,
            color: Theme.of(context).backgroundColor),
        child: Row(
          children: [
            Text(label ?? ""),
            SizedBox(
              width: 2,
            ),
            InkWell(
                onTap: onClear,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red[100]),
                    child: Icon(
                      Icons.clear,
                      size: 17,
                      color: Colors.red,
                    )))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    var jobListFilterWidgetViewModel = Provider.of<JobListFilterWidgetViewModel>(context);
    return Consumer<JobListViewModel>(builder: (context, jobListViewModel, _) {
      return Container(
        height: 36,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[200])),
            color: backgroundColor,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
            ]),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            if (jobListViewModel.hasCategory)
              filterItem(
                  context: context,
                  label: StringUtils.jobCategoryText,
                  onClear: () {
                    jobListViewModel.clearCategory();
                    jobListFilterWidgetViewModel.selectedCategory = null;

                  }),
            if (jobListViewModel.hasExperienceRange)
              filterItem(
                  context: context,
                  label: StringUtils.experienceText,
                  onClear: () {
                    jobListViewModel.clearExperienceRange();
                    jobListFilterWidgetViewModel.experienceMin = null;
                    jobListFilterWidgetViewModel.experienceMax = null;
                  }),
            if (jobListViewModel.hasSalaryRange)
              filterItem(
                  context: context,
                  label: StringUtils.salaryRangeText,
                  onClear: () {
                    jobListViewModel.clearSalaryRange();
                    jobListFilterWidgetViewModel.salaryMin = null;
                    jobListFilterWidgetViewModel.salaryMax = null;
                  }),
            if (jobListViewModel.hasDatePosted)
              filterItem(
                  context: context,
                  label: StringUtils.datePosted,
                  onClear: () {
                    jobListViewModel.clearDatePosted();
                    jobListFilterWidgetViewModel.selectedDatePosted = null;
                  }),
            if (jobListViewModel.hasJobType)
              filterItem(
                  context: context,
                  label: StringUtils.jobTypeText,
                  onClear: () {
                    jobListViewModel.clearJobType();
                    jobListFilterWidgetViewModel.selectedJobType = null;
                  }),
            if (jobListViewModel.hasLocation)
              filterItem(
                  context: context,
                  label: StringUtils.locationText,
                  onClear: () {
                    jobListViewModel.clearLocation();
                    jobListFilterWidgetViewModel.selectedLocation = null;
                  }),
            if (jobListViewModel.hasSortBy)
              filterItem(
                  context: context,
                  label: StringUtils.sortBy,
                  onClear: () {
                    jobListViewModel.clearSort();
                    jobListFilterWidgetViewModel.selectedSortBy = null;
                  }),
            if (jobListViewModel.hasGender)
              filterItem(
                  context: context,
                  label: StringUtils.genderText,
                  onClear: () {
                    jobListViewModel.clearGender();
                    jobListFilterWidgetViewModel.selectedGender = null;
                  }),
            if (jobListViewModel.hasSkill)
              filterItem(
                  context: context,
                  label: StringUtils.skillText,
                  onClear: () {
                    jobListViewModel.clearSkill();
                    jobListFilterWidgetViewModel.selectedSkill = null;
                  }),
            if (jobListViewModel.hasQualification)
              filterItem(
                  context: context,
                  label: StringUtils.qualificationText,
                  onClear: () {
                    jobListViewModel.clearQualification();
                    jobListFilterWidgetViewModel.selectedQualification = null;
                  }),
          ],
        ),
      );
    });
  }
}

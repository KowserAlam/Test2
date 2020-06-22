import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/job_list_filters.dart';
import 'package:p7app/features/job/models/jon_type_model.dart';
import 'package:p7app/features/job/models/sort_item.dart';
import 'package:p7app/features/job/view_model/job_list_filter_widget_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/features/user_profile/models/skill.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_dropdown_button_form_field.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/common_button.dart';
import 'package:p7app/main_app/views/widgets/custom_text_from_field.dart';
import 'package:provider/provider.dart';
import 'package:p7app/method_extension.dart';

class JobListFilterWidget extends StatefulWidget {
  @override
  _JobListFilterWidgetState createState() => _JobListFilterWidgetState();
}

class _JobListFilterWidgetState extends State<JobListFilterWidget>
    with AfterLayoutMixin {
  double maxSalary = 60000;
  double minSalary = 0;
  double experienceMin = 0;
  double experienceMax = 10;
  var _formKey = GlobalKey<FormState>();
  var _jobCityTextController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    var model = Provider.of<JobListFilterWidgetViewModel>(
        context, listen: false);
    model
        .getAllFilters();
    if(model.selectedLocation.isNotEmptyOrNotNull){
      _jobCityTextController.text = model.selectedLocation;
    }

  }

  _handleApply() {
    var jobListViewModel =
        Provider.of<JobListViewModel>(context, listen: false);
    var filterVM =
        Provider.of<JobListFilterWidgetViewModel>(context, listen: false);
    var filter = JobListFilters(
        salaryMax: filterVM.salaryMax?.round()?.toString() ?? "",
        salaryMin: filterVM.salaryMin?.round()?.toString() ?? "",
        experienceMax: filterVM.experienceMax?.round()?.toString() ?? "",
        experienceMin: filterVM.experienceMin?.round()?.toString() ?? "",
        skill: filterVM.selectedSkill,
        location: filterVM.selectedLocation ?? "",
        qualification: filterVM.selectedQualification ?? "",
        category: filterVM.selectedCategory.isNotEmptyOrNotNull
            ? filterVM.selectedCategory.replaceFirst("&", "%26")
            : "",
        datePosted: filterVM.selectedDatePosted ?? "",
        gender: filterVM.selectedGender ?? "",
        jobType: filterVM.selectedJobType,
        sort: filterVM.selectedSortBy);

    jobListViewModel.applyFilters(filter);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var spaceBetween = SizedBox(height: 15);

    var jobListViewModel = Provider.of<JobListViewModel>(context);

    return Consumer<JobListFilterWidgetViewModel>(
        builder: (context, jobListFilterWidgetViewModel, _) {
//          var skills = jobListFilterWidgetViewModel.skills;

      var salaryRange = RangeValues(
          jobListFilterWidgetViewModel.salaryMin ?? minSalary,
          jobListFilterWidgetViewModel.salaryMax ?? maxSalary);
      var experienceRange = RangeValues(
          jobListFilterWidgetViewModel.experienceMin ?? experienceMin,
          jobListFilterWidgetViewModel.experienceMax ?? experienceMax);

      var skillDropDownMenuItems = jobListFilterWidgetViewModel.skills
          .map((e) => DropdownMenuItem<Skill>(
                key: Key(e.id.toString()),
                value: e,
                child: Text(
                  e.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList();
      var locationDropDownMenuItems = jobListFilterWidgetViewModel.jobCity
          .map((e) => DropdownMenuItem<String>(
                key: Key(e),
                value: e,
                child: Text(
                  e,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList();
      var jobCategoriesDropDownMenuItems =
          jobListFilterWidgetViewModel.jobCategories
              .map((e) => DropdownMenuItem<String>(
                    key: Key(e),
                    value: e,
                    child: Text(
                      e.trim(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList();
      var qualificationDropDownMenuItems =
          jobListFilterWidgetViewModel.qualifications
              .map((e) => DropdownMenuItem<String>(
                    key: Key(e),
                    value: e,
                    child: Text(
                      e,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList();
      var jobTypeDropDownMenuItems = jobListFilterWidgetViewModel.jobTypes
          .map((e) => DropdownMenuItem<JobType>(
                key: Key(e.id),
                value: e,
                child: Text(
                  e.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList();
      var genderDropDownMenuItems = jobListFilterWidgetViewModel.genders
          .map((e) => DropdownMenuItem<String>(
                key: Key(e),
                value: e,
                child: Text(
                  e,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList();
      var datePostedDropDownMenuItems =
          jobListFilterWidgetViewModel.datePostedList
              .map((e) => DropdownMenuItem<String>(
                    key: Key(e),
                    value: e,
                    child: Text(
                      e,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList();
      var sortByListDropDownMenuItems = jobListFilterWidgetViewModel.sortByList
          .map((e) => DropdownMenuItem<SortItem>(
                key: Key(e.key),
                value: e,
                child: Text(e.value),
              ))
          .toList();

      return Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    StringResources.advanceFilterText,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                //reset button
                IconButton(
                  icon: Icon(FontAwesomeIcons.redo),
                  iconSize: 20,
                  onPressed: () {
                    Provider.of<JobListFilterWidgetViewModel>(context,
                            listen: false)
                        .resetState();
                    _formKey.currentState.reset();
                    _jobCityTextController.clear();
                  },
                ),
                // close button
                IconButton(
                  icon: Icon(FontAwesomeIcons.times),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(8),
                children: [
//          Row(
//            children: [
//              Text(
//                StringUtils.skillText,
//                style: Theme.of(context).textTheme.subtitle1,
//              ),
//              Expanded(
//                child: SearchableDropdown<Skill>.single(
//                  isExpanded: true,
//                  hint: Text(StringUtils.tapToSelectText),
//                  value: jobListFilterWidgetViewModel.selectedSkill,
//                  items: skillDropDownMenuItems,
//                  onChanged: (v) {
//                    debugPrint(v.toString());
//                    jobListFilterWidgetViewModel.selectedSkill = v;
//                  },
//                ),
//              ),
//
//            ],
//          ),

                  spaceBetween,
                  // sort by
                  CustomDropdownButtonFormField<SortItem>(
                    labelText: StringResources.sortBy,
                    hint: Text(StringResources.tapToSelectText),
                    value: jobListFilterWidgetViewModel.selectedSortBy ??
                        jobListFilterWidgetViewModel.sortByList[0],
                    onChanged: (v) =>
                        jobListFilterWidgetViewModel.selectedSortBy = v,
                    items: sortByListDropDownMenuItems,
                  ),
                  spaceBetween,
                  //job category
                  CustomDropdownButtonFormField<String>(
                    labelText: StringResources.jobCategoryText,
                    hint: Text(StringResources.tapToSelectText),
                    onChanged: (value) {
                      jobListFilterWidgetViewModel.selectedCategory = value;
                    },
                    isExpanded: true,
                    value: jobListFilterWidgetViewModel.selectedCategory,
                    items: jobCategoriesDropDownMenuItems,
                  ),
                  spaceBetween,
                  //location
                  CustomTextFormField(
                    labelText: StringResources.locationText,
                    controller: _jobCityTextController,
                    hintText: StringResources.jobCityHintText,
                    onChanged: (v){
                      jobListFilterWidgetViewModel.selectedLocation = v;
                    },
                  ),
//                  CustomDropdownButtonFormField<String>(
//                    labelText: StringUtils.locationText,
//                    hint: Text(StringUtils.tapToSelectText),
//                    onChanged: (value) {
//                      jobListFilterWidgetViewModel.selectedLocation = value;
//                    },
//                    value: jobListFilterWidgetViewModel.selectedLocation,
//                    items: locationDropDownMenuItems,
//                  ),
                  spaceBetween,
                  //skill
                  CustomDropdownButtonFormField(
                    labelText: StringResources.skillText,
                    hint: Text(StringResources.tapToSelectText),
                    onChanged: (value) {
                      jobListFilterWidgetViewModel.selectedSkill = value;
                    },
                    value: jobListFilterWidgetViewModel.selectedSkill,
                    items: skillDropDownMenuItems,
                  ),
                  spaceBetween,
                  // jobType
                  CustomDropdownButtonFormField<JobType>(
                    labelText: StringResources.jobTypeText,
                    hint: Text(StringResources.tapToSelectText),
                    onChanged: (value) {
                      jobListFilterWidgetViewModel.selectedJobType = value;
                    },
                    value: jobListFilterWidgetViewModel.selectedJobType,
                    items: jobTypeDropDownMenuItems,
                  ),
                  spaceBetween,
                  // salary range
                  CustomRangeSlider(
                    labelText: StringResources.salaryRangeText,
                    max: maxSalary,
                    min: minSalary,
                    values: salaryRange,
                    onChanged: jobListFilterWidgetViewModel.onchangeSalaryRange,
                    bottom: Text(
                        "${salaryRange.start.round()} ৳ - ${salaryRange.end.round()} ৳"),
                  ),
                  spaceBetween,
                  // experience
                  CustomRangeSlider(
                    labelText: StringResources.experienceText,
                    max: experienceMax,
                    min: experienceMin,
                    values: experienceRange,
                    onChanged:
                        jobListFilterWidgetViewModel.onchangeExperienceRange,
                    bottom: Text(
                        "${experienceRange.start.round()} Year - ${experienceRange.end.round()} Year"),
                  ),
                  spaceBetween,
                  //qualification
                  CustomDropdownButtonFormField(
                    labelText: StringResources.qualificationText,
                    hint: Text(StringResources.tapToSelectText),
                    onChanged: (value) {
                      jobListFilterWidgetViewModel.selectedQualification =
                          value;
                    },
                    value: jobListFilterWidgetViewModel.selectedQualification,
                    items: qualificationDropDownMenuItems,
                  ),
                  spaceBetween,
                  //gender
                  CustomDropdownButtonFormField(
                    labelText: StringResources.genderText,
                    hint: Text(StringResources.tapToSelectText),
                    onChanged: (value) {
                      jobListFilterWidgetViewModel.selectedGender = value;
                    },
                    value: jobListFilterWidgetViewModel.selectedGender,
                    items: genderDropDownMenuItems,
                  ),
                  spaceBetween,
                  CustomDropdownButtonFormField(
                    labelText: StringResources.datePosted,
                    hint: Text(StringResources.tapToSelectText),
                    onChanged: (value) {
                      jobListFilterWidgetViewModel.selectedDatePosted = value;
                    },
                    value: jobListFilterWidgetViewModel.selectedDatePosted,
                    items: datePostedDropDownMenuItems,
                  ),
                  spaceBetween,
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonButton(
              height: 50,
              width: 150,
              circularRadius: 7,
              onTap: () {
                _handleApply();
              },
              label: StringResources.applyFilterText,
            ),
          ),
        ],
      );
    });
  }
}

class CustomRangeSlider extends StatelessWidget {
  final Widget bottom;
  final String labelText;
  final double min;
  final double max;
  final RangeValues values;
  final Function(RangeValues) onChanged;

  const CustomRangeSlider({
    this.bottom,
    this.labelText,
    @required this.min,
    @required this.max,
    @required this.values,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
            text: "  ${labelText ?? ""}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ])),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: CommonStyleTextField.boxShadow,
          ),
          child: RangeSlider(
            max: max,
            min: min,
            values: values,
            onChanged: onChanged,
          ),
        ),
        SizedBox(height: 10),
        if (bottom != null) bottom,
      ],
    );
  }
}

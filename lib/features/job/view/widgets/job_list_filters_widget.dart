import 'package:after_layout/after_layout.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/job_list_filters.dart';
import 'package:p7app/features/job/models/jon_type_model.dart';
import 'package:p7app/features/job/models/sort_item.dart';
import 'package:p7app/features/job/view_model/job_list_filter_widget_view_model.dart';
import 'package:p7app/features/job/view_model/all_job_list_view_model.dart';
import 'package:p7app/main_app/models/skill.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_dropdown_button_form_field.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/common_button.dart';
import 'package:p7app/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:p7app/main_app/views/widgets/custom_text_from_field.dart';
import 'package:provider/provider.dart';
import 'package:p7app/method_extension.dart';

class JobListFilterWidget extends StatefulWidget {
  @override
  _JobListFilterWidgetState createState() => _JobListFilterWidgetState();
}

class _JobListFilterWidgetState extends State<JobListFilterWidget>
    with AfterLayoutMixin {
  double maxSalary = 1000000;
  double minSalary = 0;
  double experienceMin = 0;
  double experienceMax = 50;
  var _formKey = GlobalKey<FormState>();
  var _jobCityTextController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    var model =
    Provider.of<JobListFilterWidgetViewModel>(context, listen: false);
    model.getAllFilters();
    if (model.selectedLocation.isNotEmptyOrNotNull) {
      _jobCityTextController.text = model.selectedLocation;
    }
  }

  _handleApply() {
    var jobListViewModel =
    Provider.of<AllJobListViewModel>(context, listen: false);
    var filterVM =
    Provider.of<JobListFilterWidgetViewModel>(context, listen: false);
    String jobCategory = filterVM.selectedCategory=='-----'?'':filterVM.selectedCategory;
    String qualification = filterVM.selectedQualification =='-----'?'':filterVM.selectedQualification;
    String datePosted = filterVM.selectedDatePosted == '-----'?'':filterVM.selectedDatePosted;

    var filter = JobListFilters(
        salaryMax: filterVM.salaryMax?.round()?.toString() ?? "",
        salaryMin: filterVM.salaryMin?.round()?.toString() ?? "",
        experienceMax: filterVM.experienceMax?.round()?.toString() ?? "",
        experienceMin: filterVM.experienceMin?.round()?.toString() ?? "",
        skill: filterVM.selectedSkill,
        location: filterVM.selectedLocation ?? "",
        qualification: qualification,
        category: jobCategory.isNotEmptyOrNotNull
            ? jobCategory.replaceFirst("&", "%26")
            : "",
        datePosted: datePosted,
        //gender: filterVM.selectedGender ?? "",
        //jobType: filterVM.selectedJobType,
        sort: filterVM.selectedSortBy);

    jobListViewModel.applyFilters(filter);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var spaceBetween = SizedBox(height: 15);

    var jobListViewModel = Provider.of<AllJobListViewModel>(context);

    return Consumer<JobListFilterWidgetViewModel>(
        builder: (context, jobListFilterWidgetViewModel, _) {
//          var skills = jobListFilterWidgetViewModel.skills;

          var salaryRange = RangeValues(
              jobListFilterWidgetViewModel.salaryMin ?? minSalary,
              jobListFilterWidgetViewModel.salaryMax ?? maxSalary);
          var experienceRange = RangeValues(
              jobListFilterWidgetViewModel.experienceMin ?? experienceMin,
              jobListFilterWidgetViewModel.experienceMax ?? experienceMax);

          var datePostedDropDownMenuItems =
          jobListFilterWidgetViewModel.datePostedList
              .map((e) =>
              DropdownMenuItem<String>(
                key: Key(e),
                value: e,
                child: Text(
                  e,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
              .toList();
          var sortByListDropDownMenuItems = jobListFilterWidgetViewModel
              .sortByList
              .map((e) =>
              DropdownMenuItem<SortItem>(
                key: Key(e.key),
                value: e,
                child: Text(e.value),
              ))
              .toList();

          return Column(
            children: [
              SizedBox(height: MediaQuery
                  .of(context)
                  .padding
                  .top),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        StringResources.advanceFilterText,
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle1,
                      ),
                    ),
                    //reset button
                    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      color: Theme.of(context).primaryColor,
                      child: Text(StringResources.clearAll),
                      key: Key('filterClearAllButtonKey'),
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
                      key: Key ('filterCloseButtonKey'),
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

                      spaceBetween,
                      // sort by
                      CustomDropdownSearchFormField<SortItem>(
                          showSearchBox: false,
//                          mode: Mode.DIALOG,
                          labelText: StringResources.sortBy,
                          hintText: StringResources.tapToSelectText,
                          dropdownKey: Key ('filterSortByTextfieldKey'),
                          items: jobListFilterWidgetViewModel.sortByList,
                          itemAsString: (SortItem u) => u.value,
                          onChanged: (value) {
                            jobListFilterWidgetViewModel.selectedSortBy = value;
                          },
                          selectedItem: jobListFilterWidgetViewModel.selectedSortBy?? SortItem(key: '', value: 'Most Recent')
                      ),
                      spaceBetween,
                      CustomDropdownSearchFormField<String>(
                        showSearchBox: true,
                          popupItemDisabled: (String s) => s.startsWith('I'),
                          mode: Mode.DIALOG,
                          labelText: StringResources.jobCategoryText,
                          hintText: StringResources.tapToSelectText,
                          dropdownKey: Key('filterJobCategoryTextfieldKey'),
                          items: jobListFilterWidgetViewModel.jobCategories,
                          onChanged: (value) {
                            jobListFilterWidgetViewModel.selectedCategory =
                                value;
                          },
                          selectedItem:
                          jobListFilterWidgetViewModel.selectedCategory ),
                      spaceBetween,
                      //location
                      CustomTextFormField(
                        labelText: StringResources.locationText,
                        controller: _jobCityTextController,
                        hintText: StringResources.jobCityHintText,
                        textFieldKey: Key ('filterLocationTextfieldKey'),
                        onChanged: (v) {
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
//                  //skill
//                  CustomDropdownButtonFormField(
//                    labelText: StringResources.skillText,
//                    hint: Text(StringResources.tapToSelectText),
//                    onChanged: (value) {
//                      jobListFilterWidgetViewModel.selectedSkill = value;
//                    },
//                    value: jobListFilterWidgetViewModel.selectedSkill,
//                    items: skillDropDownMenuItems,
//                  ),
//                  spaceBetween,

                      CustomDropdownSearchFormField<Skill>(
                        showSearchBox: true,
                        popupItemDisabled: (Skill s) => s.name.startsWith('I'),
                        compareFn: (Skill v1, Skill v2) {
                          return v1.name == v2.name;
                        },
                        mode: Mode.DIALOG,
                        labelText: StringResources.skillText,
                        hintText: StringResources.tapToSelectText,
                          dropdownKey: Key ('filterSkillTextfieldKey'),
                        items: jobListFilterWidgetViewModel.skills,
                        itemAsString: (Skill u) => u.name,
                        onChanged: (value) {
                          jobListFilterWidgetViewModel.selectedSkill = value;
                        },
                        selectedItem:
                        jobListFilterWidgetViewModel.selectedSkill
                  ),
//                      spaceBetween,
//                      // jobType
//                      CustomDropdownButtonFormField<JobType>(
//                        labelText: StringResources.jobTypeText,
//                        hint: Text(StringResources.tapToSelectText),
//                        customDropdownKey: Key ('filterJobTypeTextfieldKey'),
//                        onChanged: (value) {
//                          jobListFilterWidgetViewModel.selectedJobType = value;
//                        },
//                        value: jobListFilterWidgetViewModel.selectedJobType,
//                        items: jobTypeDropDownMenuItems,
//                      ),
                      spaceBetween,
                      // salary range
                      CustomRangeSlider(
                        slideKey: Key("salaryRangeKey"),
                        labelText: StringResources.salaryRangeText,
                        max: maxSalary,
                        min: minSalary,
                        values: salaryRange,
                        onChanged: jobListFilterWidgetViewModel
                            .onchangeSalaryRange,
                        bottom: Text(
                            "${salaryRange.start.round()} ৳ - ${salaryRange.end
                                .round()} ৳"),
                      ),
                      spaceBetween,
                      // experience
                      CustomRangeSlider(
                        slideKey: Key("experienceRangeKey"),
                        labelText: StringResources.experienceText,
                        max: experienceMax,
                        min: experienceMin,
                        values: experienceRange,
                        onChanged:
                        jobListFilterWidgetViewModel.onchangeExperienceRange,
                        bottom: Text(
                            "${experienceRange.start
                                .round()} Year - ${experienceRange.end
                                .round()} Year"),
                      ),
                      spaceBetween,
                      //qualification
                      // CustomDropdownButtonFormField(
                      //   labelText: StringResources.qualificationText,
                      //   hint: Text(StringResources.tapToSelectText),
                      //   customDropdownKey: Key('filterQualificationTextfieldKey'),
                      //   onChanged: (value) {
                      //     jobListFilterWidgetViewModel.selectedQualification =
                      //         value;
                      //   },
                      //   value: jobListFilterWidgetViewModel
                      //       .selectedQualification,
                      //   items: qualificationDropDownMenuItems,
                      // ),
                      CustomDropdownSearchFormField<String>(
                          showSearchBox: false,
//                          mode: Mode.DIALOG,
                          labelText: StringResources.qualificationText,
                          hintText: StringResources.tapToSelectText,
                          dropdownKey: Key ('filterSkillTextfieldKey'),
                          items: jobListFilterWidgetViewModel.qualifications,
                          itemAsString: ( u) => u,
                          onChanged: (value) {
                            jobListFilterWidgetViewModel.selectedQualification = value;
                          },
                          selectedItem:
                          jobListFilterWidgetViewModel.selectedQualification
                      ),
//                      spaceBetween,
                      //gender
//                      CustomDropdownButtonFormField(
//                        labelText: StringResources.genderText,
//                        hint: Text(StringResources.tapToSelectText),
//                        customDropdownKey: Key ('filterGenderTextfieldKey'),
//                        onChanged: (value) {
//                          jobListFilterWidgetViewModel.selectedGender = value;
//                        },
//                        value: jobListFilterWidgetViewModel.selectedGender,
//                        items: genderDropDownMenuItems,
//                      ),
                      spaceBetween,
                      CustomDropdownSearchFormField<String>(
                          showSearchBox: false,
//                          mode: Mode.DIALOG,
                          labelText: StringResources.datePosted,
                          hintText: StringResources.tapToSelectText,
                          dropdownKey: Key ('filterDatePostedTextfieldKey'),
                          items: jobListFilterWidgetViewModel.datePostedList,
                          itemAsString: ( u) => u,
                          onChanged: (value) {
                            jobListFilterWidgetViewModel.selectedDatePosted = value;
                          },
                          selectedItem:
                          jobListFilterWidgetViewModel.selectedDatePosted
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
                  fontSize: 14,
                  height: 40,
                  width: 140,
                  circularRadius: 40,
                  onTap: () {
                    _handleApply();
                  },
                  label: StringResources.applyFilterText,
                  key: Key ('applyFilterButtonKey'),
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
  final Key slideKey;

  const CustomRangeSlider({
    this.slideKey,
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
            color: Theme
                .of(context)
                .backgroundColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: CommonStyle.boxShadow,
          ),
          child: RangeSlider(
            key: slideKey,
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Colors.grey,
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

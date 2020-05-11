import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/job_list_filters.dart';
import 'package:p7app/features/job/view_model/job_list_filter_widget_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/features/user_profile/models/skill.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_dropdown_button_form_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/common_button.dart';
import 'package:provider/provider.dart';


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

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<JobListFilterWidgetViewModel>(context, listen: false)
        .getAllFilters();
  }

  @override
  Widget build(BuildContext context) {
    var spaceBetween = SizedBox(height: 10);

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

      return Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.times),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
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
                CustomDropdownButtonFormField(
                  labelText: StringUtils.skillText,
                  hint: Text(StringUtils.tapToSelectText),
                  onChanged: (value) {
                    jobListFilterWidgetViewModel.selectedSkill = value;
                  },
                  value:  jobListFilterWidgetViewModel.selectedSkill,
                  items: skillDropDownMenuItems,
                ),
                spaceBetween,
                CustomRangeSlider(
                  labelText: StringUtils.salaryRangeText,
                  max: maxSalary,
                  min: minSalary,
                  values: salaryRange,
                  onChanged: jobListFilterWidgetViewModel.onchangeSalaryRange,
                  bottom: Text(
                      "${salaryRange.start.round()} ৳ - ${salaryRange.end.round()} ৳"),
                ),
                spaceBetween,
                CustomRangeSlider(
                  labelText: StringUtils.experienceText,
                  max: experienceMax,
                  min: experienceMin,
                  values: experienceRange,
                  onChanged:
                      jobListFilterWidgetViewModel.onchangeExperienceRange,
                  bottom: Text(
                      "${experienceRange.start.round()} Year - ${experienceRange.end.round()} Year"),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonButton(
              height: 50,
              width: 150,
              circularRadius: 7,
              onTap: () {
                Provider.of<JobListViewModel>(context,listen: false).applyFilters(JobListFilters(
                  salaryMax: salaryRange?.end?.round()?.toString(),
                  salaryMin: salaryRange?.start?.round()?.toString(),
                  experienceMax: experienceRange?.end?.round()?.toString(),
                  experienceMin: experienceRange?.start?.round()?.toString(),
                  skill: jobListFilterWidgetViewModel.selectedSkill?.id.toString()??""
                ));
                Navigator.pop(context);
              },
              label: StringUtils.applyFilterText,
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

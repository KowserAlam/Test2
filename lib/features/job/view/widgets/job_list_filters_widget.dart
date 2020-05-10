import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:p7app/features/job/view_model/job_list_filter_widget_view_model.dart';
import 'package:p7app/features/user_profile/models/skill.dart';
import 'package:p7app/features/user_profile/repositories/skill_list_repository.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class JobListFilterWidget extends StatefulWidget {
  @override
  _JobListFilterWidgetState createState() => _JobListFilterWidgetState();
}

class _JobListFilterWidgetState extends State<JobListFilterWidget>
    with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<JobListFilterWidgetViewModel>(context, listen: false)
        .getAllFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobListFilterWidgetViewModel>(
        builder: (context, jobListFilterWidgetViewModel, _) {
//          var skills = jobListFilterWidgetViewModel.skills;
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
      return ListView(
        padding: EdgeInsets.all(8),
        children: [
          SearchableDropdown<Skill>.single(
            value: jobListFilterWidgetViewModel.selectedSkill,
            items: skillDropDownMenuItems,
            onChanged: (v) {
              debugPrint(v.toString());
              jobListFilterWidgetViewModel.selectedSkill = v;
            },
          ),
        ],
      );
    });
  }
}

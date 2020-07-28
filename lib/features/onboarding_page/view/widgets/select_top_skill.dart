import 'package:flutter/material.dart';
import 'package:p7app/features/onboarding_page/view/widgets/add_skill_widget.dart';
import 'package:p7app/features/onboarding_page/view_models/additional_info_view_model.dart';
import 'package:p7app/features/user_profile/models/skill.dart';
import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:provider/provider.dart';

class SelectTopSkill extends StatefulWidget {
  @override
  _SelectTopSkillState createState() => _SelectTopSkillState();
}

class _SelectTopSkillState extends State<SelectTopSkill> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdditionalInfoViewModel>(builder: (context, vm, _) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                StringResources.addYourTopSkillText,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            AddSkillWidget(
              onAdd: vm.addSkill,
              items: vm.skillList,
            ),
            SizedBox(height: 10),
            Expanded(
              child: vm.selectedSkills.length == 0
                  ? Container(
//                color: Theme.of(context).accentColor.withOpacity(0.1),
                      child: Center(
                        child: Text(
                          StringResources.noSkillSelectedText,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey),
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 2)),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            StringResources.skillsText,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: vm.selectedSkills.length,
                                itemBuilder: (context, index) {
                                  var skillInfo = vm.selectedSkills[index];
                                  return ListTile(
                                    title: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                skillInfo?.skill?.name ?? "")),
                                        Text(
                                            "  ${skillInfo?.rating?.toStringAsFixed(2) ?? ""}"),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.cancel),
                                      onPressed: () {
                                        vm.removeSkill(skillInfo.profSkillId);
                                      },
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ),
      );
    });
  }
}

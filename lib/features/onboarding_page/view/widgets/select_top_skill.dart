import 'package:flutter/material.dart';
import 'package:p7app/features/onboarding_page/view_models/additional_info_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:provider/provider.dart';

class SelectTopSkill extends StatelessWidget {
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
            Text(StringResources.addYourTopSkillText),
            CustomDropdownSearchFormField(
              onChanged: vm.addSkill,
              showSearchBox: true,
              items: vm.skillList,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: vm.selectedSkills.length,
                  itemBuilder: (context, index) {
                    var skill = vm.skillList[index];
                    return ListTile(
                      title: Text(skill?.name ?? ""),
                      trailing: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          vm.removeSkill(index);
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
    });
  }
}

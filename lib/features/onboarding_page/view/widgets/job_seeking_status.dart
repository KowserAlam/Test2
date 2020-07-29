import 'package:flutter/material.dart';
import 'package:p7app/features/onboarding_page/view/widgets/select_location.dart';
import 'package:p7app/features/onboarding_page/view/widgets/select_top_skill.dart';
import 'package:p7app/features/onboarding_page/view_models/additional_info_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:provider/provider.dart';

class JobSeekingStatus extends StatefulWidget {
  @override
  _JobSeekingStatusState createState() => _JobSeekingStatusState();
}

class _JobSeekingStatusState extends State<JobSeekingStatus> {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<AdditionalInfoViewModel>(context);
    var jobSeekingStatusList = vm.jobSeekingStatusList;
    var experienceList = vm.experienceList;
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      StringResources.pleaseProvideSomeAdditionalInfoText,
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      StringResources.itWillHelpUsSupportYouWithJobText,
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(StringResources.areYouLookingForJobText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue)),
              ),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(jobSeekingStatusList.length, (index) {
                    return RadioListTile<String>(
                      title: Text(jobSeekingStatusList[index]),
                      onChanged: vm.onJobSeekingRadioButtonChanges,
                      value: jobSeekingStatusList[index],
                      groupValue: vm.radioValue,
                    );
                  })),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                child: CustomDropdownSearchFormField<String>(
                  labelText: StringResources.yearsOfExperience,
                  items: experienceList,
                  hintText: StringResources.tapToSelectText,
                  selectedItem: vm.selectedExperience,
                  onChanged: (v) {
                    vm.selectedExperience = v;
                  },
                ),
              ),
              SelectLocation(),
            ],
          ),
        ),
      ),
    );
  }
}

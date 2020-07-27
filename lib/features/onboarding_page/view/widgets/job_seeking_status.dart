import 'package:flutter/material.dart';
import 'package:p7app/main_app/repositories/job_experience_list_repository.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:p7app/main_app/views/widgets/custom_text_field.dart';

class JobSeekingStatus extends StatefulWidget {
  @override
  _JobSeekingStatusState createState() => _JobSeekingStatusState();
}

class _JobSeekingStatusState extends State<JobSeekingStatus> {
  var list = <String>[
    "Yes, I'm actively looking",
    "I'm not looking, but open to opportunities",
    "Just exploring",
  ];
  List<String> experienceList = [];
  String _radioValue; //
  String selectedExperience;// Initial definition of radio button value

  @override
  void initState() {
    JobExperienceListRepository().getList().then((value) {
      experienceList = value.fold((l) => [], (r) => r);
      setState(() {});
    });
    super.initState();
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value; //Debug the choice in console
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Please provide some additional information. ",
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "It will help us "
                      " support you with job  recommendations better suited for you. ",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .apply(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(list.length, (index) {
                    return RadioListTile<String>(
                      title: Text(list[index]),
                      onChanged: radioButtonChanges,
                      value: list[index],
                      groupValue: _radioValue,
                    );
                  })),
              SizedBox(
                height: 10,
              ),
              CustomDropdownSearchFormField<String>(
                labelText: StringResources.experience,
                isRequired: true,
                items: experienceList,
                selectedItem: selectedExperience,
                onChanged: (v){
                  selectedExperience = v;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

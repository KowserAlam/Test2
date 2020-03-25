import 'package:p7app/features/user_profile/providers/user_provider.dart';
import 'package:p7app/features/user_profile/widgets/personal_info_widget.dart';
import 'package:p7app/features/user_profile/widgets/technical_skill_list_item.dart';
import 'package:p7app/features/user_profile/widgets/user_info_list_item.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../add_edit_education_screen.dart';
import '../add_edit_experience_screen.dart';
import '../add_edit_technical_skill_screen.dart';
import 'educations_list_item.dart';
import 'experience_list_item.dart';

class UserDetailsInfoListWidget extends StatefulWidget {
  @override
  _UserDetailsInfoListWidgetState createState() =>
      _UserDetailsInfoListWidgetState();
}

class _UserDetailsInfoListWidgetState extends State<UserDetailsInfoListWidget> {
  @override
  Widget build(BuildContext context) {
    var itemList = [
      ///Experience

      Consumer<UserProvider>(builder: (context, userProvider, _) {
        var expList = userProvider.userData.experienceList;
        return UserInfoListItem(
          icon: FontAwesomeIcons.globeEurope,
          label: StringUtils.experienceText,
          onTapAddNewAction: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => AddNewExperienceScreen()));
          },
          expandedChildren: List.generate(expList.length, (int index) {
            var exp = expList[index];
            return ExperienceListItem(
              experienceModel: exp,
              onTapEdit: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => AddNewExperienceScreen(
                              index: index,
                              experienceModel: exp,
                            )));
              },
            );
          }),
        );
      }),

      ///Education
      Consumer<UserProvider>(builder: (context, userProvider, _) {
        var eduList = userProvider.userData.educationModelList;
        return UserInfoListItem(
          icon: FontAwesomeIcons.university,
          label: StringUtils.educationsText,
          onTapAddNewAction: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => AddEditEducationScreen()));
          },
          expandedChildren: List.generate(eduList.length, (int i) {
            return EducationsListItem(
              educationItemModel: eduList[i],
              index: i,
            );
          }),
        );
      }),

      ///Skill

      Consumer<UserProvider>(builder: (context, userProvider, _) {
        var list = userProvider.userData.technicalSkillList;

        return UserInfoListItem(
          icon: FontAwesomeIcons.brain,
          label: StringUtils.technicalSkillText,
          onTapAddNewAction: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => AddEditTechnicalSkill()));
          },
          expandedChildren: List.generate(list.length, (index) {
            var skill = list[index];
            return TechnicalSkillListItem(
              technicalSkill: skill,
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => AddEditTechnicalSkill(
                              index: index,
                              technicalSkill: skill,
                            )));
              },
            );
          }),
        );
      }),

      /// Personal info
      PersonalInfoWidget(),

      /// Projects
      Consumer<UserProvider>(builder: (context, userProvider, _) {
        var list = userProvider.userData.technicalSkillList;

        return UserInfoListItem(
          icon: FontAwesomeIcons.hammer,
          label: StringUtils.projectsText,
          onTapAddNewAction: () {
//            Navigator.push(
//                context,
//                CupertinoPageRoute(
//                    builder: (context) => AddEditTechnicalSkill()));
          },
          expandedChildren: List.generate(list.length, (index) {
            var skill = list[index];
            return ListTile(
              title: Text("Project Name"),
              subtitle: Text("Project Duration"),
            );
          }),
        );
      }),

      /// other
      Consumer<UserProvider>(builder: (context, userProvider, _) {
        var list = userProvider.userData.technicalSkillList;

        return UserInfoListItem(
          icon: FontAwesomeIcons.fileAlt,
          label: StringUtils.otherText,
          expandedChildren: [
            Material(
              color: Theme.of(context).canvasColor,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Career Objective:"),
                    subtitle: Padding(
                      padding: const EdgeInsets.all( 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Description"),
                          Text("Current Designation"),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Achievements:"),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Name Of Achievements"),
                          Text("Date"),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Declaration:"),
                    subtitle:   Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text("Brief Details text"),
                    ),
                  ),
                  ListTile(
                    title: Text("Interest/Hobbies:"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4), child: Text("Hobbies 1"),),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4), child: Text("Hobbies 2"),),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4), child: Text("Hobbies 3"),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),

      /// Reference
      Consumer<UserProvider>(builder: (context, userProvider, _) {
        var list = userProvider.userData.technicalSkillList;

        return UserInfoListItem(
          icon: FontAwesomeIcons.bookReader,
          label: StringUtils.referenceText,
          onTapAddNewAction: () {
//            Navigator.push(
//                context,
//                CupertinoPageRoute(
//                    builder: (context) => AddEditTechnicalSkill()));
          },
          expandedChildren: List.generate(list.length, (index) {
            var skill = list[index];
            return Material(
              color: Theme.of(context).canvasColor,
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(FontAwesomeIcons.user),
                ),
                title: Text("Name"),
                subtitle: Text("Current Position"),
              ),
            );
          }),
        );
      }),
    ];

    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: itemList.length,
      separatorBuilder: (context, int) => Divider(
        height: 3,
        color: Colors.grey,
      ),
      itemBuilder: (context, index) => itemList[index],
    );
  }
}

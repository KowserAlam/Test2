import 'package:p7app/features/user_profile/providers/user_provider.dart';
import 'package:p7app/features/user_profile/styles/profile_common_style.dart';
import 'package:p7app/features/user_profile/widgets/personal_info_widget.dart';
import 'package:p7app/features/user_profile/widgets/technical_skill_list_item.dart';
import 'package:p7app/features/user_profile/widgets/user_info_list_item.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
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

  bool isInEditModeExperience = false;
  bool isInEditModeEducation = false;


  @override
  Widget build(BuildContext context) {

    var itemList = [

      /// about me



      ///Experience

      Consumer<UserProvider>(builder: (context, userProvider, _) {
        var expList = userProvider.userData.experienceList;
        return UserInfoListItem(
          isInEditMode: isInEditModeExperience,
          onTapEditAction: (v){
            isInEditModeExperience = v;
            setState(() {

            });
          },
          icon: FontAwesomeIcons.globeEurope,
          label: StringUtils.experienceText,
          onTapAddNewAction: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => AddNewExperienceScreen()));
          },
          children: List.generate(expList.length, (int index) {
            var exp = expList[index];
            return ExperienceListItem(
              isInEditMode:             isInEditModeExperience,
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
          isInEditMode: isInEditModeEducation,
          icon: FontAwesomeIcons.university,
          label: StringUtils.educationsText,
          onTapEditAction: (bool value){
            setState(() {
              isInEditModeEducation = value;
              print(value);
            });
          },
          onTapAddNewAction: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => AddEditEducationScreen()));
          },
          children: List.generate(eduList.length, (int i) {
            return EducationsListItem(
              educationItemModel: eduList[i],
              index: i,
              isInEditMode: isInEditModeEducation,
            );
          }),
        );
      }),

      ///Skill

      Consumer<UserProvider>(builder: (context, userProvider, _) {
        var list = userProvider.userData.technicalSkillList;

        return UserInfoListItem(
          icon: FontAwesomeIcons.brain,
          label: StringUtils.personalSkillText,
          onTapAddNewAction: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => AddEditTechnicalSkill()));
          },
          children: List.generate(list.length, (index) {
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

      /// Portfolio
      Consumer<UserProvider>(builder: (context, userProvider, _) {
        var list = userProvider.userData.technicalSkillList;

        return UserInfoListItem(
          icon: FontAwesomeIcons.wallet,
          label: StringUtils.projectsText,
          onTapAddNewAction: () {
//            Navigator.push(
//                context,
//                CupertinoPageRoute(
//                    builder: (context) => AddEditTechnicalSkill()));
          },
          children: List.generate(list.length, (index) {
            var skill = list[index];
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: ProfileCommonStyle.boxShadow,),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Image.asset(kImagePlaceHolderAsset,height: 55,width: 55,),
                title: Text("Project Name"),
                subtitle: Text("Project Duration"),
              ),
            );
          }),
        );
      }),

      /// Certifications
      Consumer<UserProvider>(builder: (context, userProvider, _) {
        var list = userProvider.userData.technicalSkillList;

        return UserInfoListItem(
          icon: FontAwesomeIcons.certificate,
          label: StringUtils.certificationsText,
          onTapAddNewAction: () {
//            Navigator.push(
//                context,
//                CupertinoPageRoute(
//                    builder: (context) => AddEditTechnicalSkill()));
          },
          children: List.generate(1, (index) {
            var skill = list[index];
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: ProfileCommonStyle.boxShadow,),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  height: 55,
                    width: 55,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Icon(FontAwesomeIcons.certificate)),
                title: Text("AWS Certified Solutions Architect - Associate"),
                subtitle: Text("Issue by: IBM"),
              ),
            );
          }),
        );
      }),

      /// Memberships
      Consumer<UserProvider>(builder: (context, userProvider, _) {
        var list = userProvider.userData.technicalSkillList;

        return UserInfoListItem(
          icon: FontAwesomeIcons.users,
          label: StringUtils.membershipsText,
          onTapAddNewAction: () {
//            Navigator.push(
//                context,
//                CupertinoPageRoute(
//                    builder: (context) => AddEditTechnicalSkill()));
          },
          children: List.generate(1, (index) {
            var skill = list[index];
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: ProfileCommonStyle.boxShadow,),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                    height: 55,
                    width: 55,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Icon(FontAwesomeIcons.users)),
                title: Text("Member of IEE"),
                subtitle: Text("Jan 10,2020 - Ongoing"),
              ),
            );
          }),
        );
      }),

      /// References
      Consumer<UserProvider>(builder: (context, userProvider, _) {
        var list = userProvider.userData.technicalSkillList;

        return UserInfoListItem(
          icon: FontAwesomeIcons.bookReader,
          label: StringUtils.referencesText,
          onTapAddNewAction: () {
//            Navigator.push(
//                context,
//                CupertinoPageRoute(
//                    builder: (context) => AddEditTechnicalSkill()));
          },
          children: List.generate(list.length, (index) {
            var ref = list[index];
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: ProfileCommonStyle.boxShadow,),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  height: 55,
                  width: 55,
                  color: Theme.of(context).backgroundColor,
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
      separatorBuilder: (context, int) => SizedBox(
        height: 15,
      ),
      itemBuilder: (context, index) => itemList[index],
    );
  }
}

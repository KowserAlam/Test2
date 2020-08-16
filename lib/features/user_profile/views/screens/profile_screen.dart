import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/settings/setings_screen.dart';
import 'package:p7app/features/user_profile/models/member_ship_info.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/screens/add_edit_education_screen.dart';
import 'package:p7app/features/user_profile/views/screens/add_edit_experience_screen.dart';
import 'package:p7app/features/user_profile/views/screens/add_edit_professional_skill_screen.dart';
import 'package:p7app/features/user_profile/views/screens/edit_portfolio_screen.dart';
import 'package:p7app/features/user_profile/views/screens/edit_reference_screen.dart';
import 'package:p7app/features/user_profile/views/widgets/certifications_list_item_widget.dart';
import 'package:p7app/features/user_profile/views/widgets/contact_info_widget.dart';
import 'package:p7app/features/user_profile/views/widgets/educations_list_item.dart';
import 'package:p7app/features/user_profile/views/widgets/experience_list_item.dart';
import 'package:p7app/features/user_profile/views/widgets/membership_list_item.dart';
import 'package:p7app/features/user_profile/views/widgets/personal_info_widget.dart';
import 'package:p7app/features/user_profile/views/widgets/portfolio_list_item_widget.dart';
import 'package:p7app/features/user_profile/views/widgets/professional_skill_list_item.dart';
import 'package:p7app/features/user_profile/views/widgets/references_list_item_widget.dart';
import 'package:p7app/features/user_profile/views/widgets/user_info_list_item.dart';
import 'package:p7app/features/user_profile/views/widgets/user_profile_header.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/common_prompt_dialog.dart';
import 'package:p7app/main_app/views/widgets/failure_widget.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:p7app/main_app/views/widgets/rectangular_button.dart';
import 'package:provider/provider.dart';

import 'edit_certifications_screen.dart';
import 'edit_memberships_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AfterLayoutMixin {
  bool isInEditModeExperience = false;
  bool isInEditModeEducation = false;
  bool isInEditModeSkill = false;
  bool isInEditModePortfolio = false;
  bool isInEditModeCertifications = false;
  bool isInEditModeMembersShip = false;
  bool isInEditModeReferences = false;

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<UserProfileViewModel>(context, listen: false)
        .getUserData(isFormOnPageLoad: true);
  }

  Widget userContactInfo(context) => InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      child: Consumer<UserProfileViewModel>(
                          builder: (context, userProfileViewModel, _) {
                        var user = userProfileViewModel.userData;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Spacer(),
                              Divider(),
                              Text(user.personalInfo.email ?? ""),
                              Divider(),
                              Text(
                                user.personalInfo.phone ?? "",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Divider(),
                              Text(user.personalInfo.address ?? ""),
                              Divider(),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                );
              });
        },
        child: Text(
          StringResources.contactInfoText,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      );

  Widget userProfileViewAndEditWidget(context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
//        RectangularButton(
//          text: StringsEn.publicView,
//          onPressed: () {},
//        ),
//        SizedBox(
//          width: 10,
//        ),
          RectangularButton(
            primaryFill: false,
            text: StringResources.editProfileText,
            onPressed: () {},
          )
        ],
      );



  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;


    // widgets

    var experienceWidget = Consumer<UserProfileViewModel>(
        builder: (context, userProfileViewModel, _) {
      var expList = userProfileViewModel.userData.experienceInfo;

      return UserInfoListItem(
        isInEditMode: isInEditModeExperience,
        penKey: Key('myProfileExperiencePenKey'),
        addKey: Key('myProfileExperienceAddKey'),
        onTapEditAction: () {
          isInEditModeExperience = !isInEditModeExperience;
          setState(() {});
        },
        icon: FontAwesomeIcons.globeEurope,
        label: StringResources.workExperienceText,
        onTapAddNewAction: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      AddNewExperienceScreen(previouslyAddedExp: expList)));
        },
        children: List.generate(expList.length, (int index) {
          var exp = expList[index];
          return ExperienceListItem(
            isInEditMode: isInEditModeExperience,
            experienceInfoModel: exp,
            onTapEdit: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => AddNewExperienceScreen(
                            index: index,
                            experienceInfoModel: exp,
                            previouslyAddedExp: expList,
                          )));
            },
            onTapDelete: () async {
              var val = await _deleteConfirmationDialog();
              if (val) userProfileViewModel.deleteExperienceData(exp, index);
            },
          );
        }),
      );
    });
    var educationWidget = Consumer<UserProfileViewModel>(
        builder: (context, userProfileViewModel, _) {
      var eduList = userProfileViewModel.userData.eduInfo;

      return UserInfoListItem(
        isInEditMode: isInEditModeEducation,
        icon: FontAwesomeIcons.university,
        label: StringResources.educationsText,
        onTapEditAction: () {
          setState(() {
            isInEditModeEducation = !isInEditModeEducation;
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
            eduInfoModel: eduList[i],
            index: i,
            isInEditMode: isInEditModeEducation,
            onTapDelete: () async {
              var val = await _deleteConfirmationDialog();
              if (val)
                Provider.of<UserProfileViewModel>(context, listen: false)
                    .deleteEduInfo(eduList[i], i);
            },
            onTapEdit: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => AddEditEducationScreen(
                            educationModel: eduList[i],
                            index: i,
                          )));
            },
          );
        }),
      );
    });
    var skillsWidget = Consumer<UserProfileViewModel>(
        builder: (context, userProfileViewModel, _) {
      var list = userProfileViewModel.userData.skillInfo;
      return UserInfoListItem(
        isInEditMode: isInEditModeSkill,
        addKey: Key('myProfileAddSkillAdd'),
        penKey: Key('myProfileAddSkillPen'),
        onTapEditAction: () {
          isInEditModeSkill = !isInEditModeSkill;
          setState(() {});
        },
        icon: FontAwesomeIcons.tools,
        label: StringResources.professionalSkillText,
        onTapAddNewAction: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => AddEditProfessionalSkill(
                        previouslyAddedSkills: list,
                      )));
        },
        children: List.generate(list.length, (index) {
          var skill = list[index];
          return ProfessionalSkillListItem(
            isInEditMode: isInEditModeSkill,
            skillInfo: skill,
            onTapDelete: () async {
              var val = await _deleteConfirmationDialog();
              if (val) userProfileViewModel.deleteSkillData(skill, index);
            },
            onTapEdit: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => AddEditProfessionalSkill(
                            skillInfo: skill,
                            index: index,
                            previouslyAddedSkills: list,
                          )));
            },
          );
        }),
      );
    });
    var personalInfoWidget = PersonalInfoWidget();
    var contactInfoWidget = ContactInfoWidget();
    var portfolioWidget = Consumer<UserProfileViewModel>(
        builder: (context, userProfileViewModel, _) {
      var list = userProfileViewModel.userData.portfolioInfo;

      return UserInfoListItem(
        isInEditMode: isInEditModePortfolio,
        onTapEditAction: () {
          isInEditModePortfolio = !isInEditModePortfolio;
          setState(() {});
        },
        icon: FontAwesomeIcons.wallet,
        label: StringResources.projectsText,
        onTapAddNewAction: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => EditPortfolio()));
        },
        children: List.generate(list.length, (index) {
          var port = list[index];
          return PortfolioListItemWidget(
            isInEditMode: isInEditModePortfolio,
            onTapDelete: () async {
              var val = await _deleteConfirmationDialog();
              if (val) userProfileViewModel.deletePortfolio(port, index);
            },
            portfolioInfo: port,
            onTapEdit: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => EditPortfolio(
                            portfolioInfo: port,
                            index: index,
                          )));
            },
          );
        }),
      );
    });
    var certificationsWidget = Consumer<UserProfileViewModel>(
        builder: (context, userProfileViewModel, _) {
      var list = userProfileViewModel.userData.certificationInfo;

      return UserInfoListItem(
        isInEditMode: isInEditModeCertifications,
        onTapEditAction: () {
          isInEditModeCertifications = !isInEditModeCertifications;
          setState(() {});
        },
        icon: FontAwesomeIcons.certificate,
        label: StringResources.certificationsText,
        onTapAddNewAction: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => EditCertification(
                        previouslyAddedCertificates: list,
                      )));
        },
        children: List.generate(list.length, (index) {
          var cer = list[index];
          return CertificationsListItemWidget(
            isInEditMode: isInEditModeCertifications,
            certificationInfo: cer,
            onTapDelete: () async {
              var val = await _deleteConfirmationDialog();
              if (val) userProfileViewModel.deleteCertificationData(cer, index);
            },
            onTapEdit: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => EditCertification(
                            certificationInfo: cer,
                            index: index,
                            previouslyAddedCertificates: list,
                          )));
            },
          );
        }),
      );
    });
    var memberShipWidget = Consumer<UserProfileViewModel>(
        builder: (context, userProfileViewModel, _) {
      List<MembershipInfo> list = userProfileViewModel.userData.membershipInfo;

      return UserInfoListItem(
        isInEditMode: isInEditModeMembersShip,
        onTapEditAction: () {
          isInEditModeMembersShip = !isInEditModeMembersShip;
          setState(() {});
        },
        icon: FontAwesomeIcons.users,
        label: StringResources.membershipsText,
        onTapAddNewAction: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => EditMemberShips()));
        },
        children: List.generate(list.length, (index) {
          var memberShip = list[index];
          return MemberShipListItem(
            isInEditMode: isInEditModeMembersShip,
            memberShip: memberShip,
            onTapEdit: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => EditMemberShips(
                            membershipInfo: memberShip,
                            index: index,
                          )));
            },
            onTapDelete: () async {
              var val = await _deleteConfirmationDialog();
              if (val)
                userProfileViewModel.deleteMembershipData(memberShip, index);
            },
          );
        }),
      );
    });
    var referencesWidget = Consumer<UserProfileViewModel>(
        builder: (context, userProfileViewModel, _) {
      var referenceList = userProfileViewModel.userData.referenceData;

      return UserInfoListItem(
        isInEditMode: isInEditModeReferences,
        penKey: Key('myProfileAddReferencesPen'),
        addKey: Key('myProfileAddReferencesAdd'),
        onTapEditAction: () {
          isInEditModeReferences = !isInEditModeReferences;
          setState(() {});
        },
        icon: FontAwesomeIcons.bookReader,
        label: StringResources.referencesText,
        onTapAddNewAction: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => EditReferenceScreen()));
        },
        children: List.generate(referenceList.length, (index) {
          var ref = referenceList[index];
          return ReferencesListItemWidget(
            isInEditMode: isInEditModeReferences,
            index: index,
            referenceData: ref,
            onTapDelete: () async {
              var val = await _deleteConfirmationDialog();
              if (val) userProfileViewModel.deleteReferenceData(ref, index);
            },
            onTapEdit: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => EditReferenceScreen(
                            referenceData: ref,
                            index: index,
                          )));
            },
          );
        }),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.myProfileText, key: Key('myProfileAppbarTitle'),),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return Provider.of<UserProfileViewModel>(context, listen: false)
              .getUserData();
        },
        child: SingleChildScrollView(
          key: Key('myProfileScrollView'),
          physics: AlwaysScrollableScrollPhysics(),
          child: Consumer<UserProfileViewModel>(
              builder: (context, userProfileViewModel, child) {
            if (userProfileViewModel.appError != null) {
              switch (userProfileViewModel.appError) {
                case AppError.serverError:
                  return FailureFullScreenWidget(
                    errorMessage: StringResources.unableToLoadData,
                    onTap: () {
                      return Provider.of<UserProfileViewModel>(context,
                              listen: false)
                          .getUserData();
                    },
                  );

                case AppError.networkError:
                  return FailureFullScreenWidget(
                    errorMessage: StringResources.unableToReachServerMessage,
                    onTap: () {
                      return Provider.of<UserProfileViewModel>(context,
                              listen: false)
                          .getUserData();
                    },
                  );

                default:
                  return FailureFullScreenWidget(
                    errorMessage: StringResources.somethingIsWrong,
                    onTap: () {
                      return Provider.of<UserProfileViewModel>(context,
                              listen: false)
                          .getUserData();
                    },
                  );
              }
            }
            if (userProfileViewModel.userData == null) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: Loader()),
              );
            }
            return Column(
              children: <Widget>[
                UserProfileHeader(),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      /// Experience
                      experienceWidget,
                      SizedBox(height: 15),

                      ///Education
                      educationWidget,
                      SizedBox(height: 15),

                      ///Skill
                      skillsWidget,
                      SizedBox(height: 15),

                      /// Portfolio
                      portfolioWidget,
                      SizedBox(height: 15),

                      /// Certifications
                      certificationsWidget,
                      SizedBox(height: 15),

                      /// Memberships
                      memberShipWidget,
                      SizedBox(height: 15),

                      /// References
                      referencesWidget,
                      SizedBox(height: 15),

                      /// Personal info
                      personalInfoWidget,
                      SizedBox(height: 15),
//                      SubscribeJobAlert(),
//                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Future<bool> _deleteConfirmationDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return CommonPromptDialog(
            titleText: StringResources.doYouWantToDeleteText,
            onCancel: () {
              Navigator.of(context).pop(false);
            },
            onAccept: () {
              Navigator.of(context).pop(true);
            },
          );
        }).then((value) {
      if (value == null) return false;
      return value;
    });
  }
}

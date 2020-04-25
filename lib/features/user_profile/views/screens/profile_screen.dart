import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:p7app/features/user_profile/views/screens/edit_portfolio_screen.dart';
import 'package:p7app/features/user_profile/views/screens/edit_reference_screen.dart';
import 'package:p7app/features/user_profile/views/screens/portfolio_list_item_widget.dart';
import 'package:p7app/features/user_profile/views/screens/certifications_list_item_widget.dart';
import 'package:p7app/features/user_profile/views/widgets/references_list_item_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/models/member_ship_info.dart';
import 'package:p7app/features/user_profile/views/screens/add_edit_education_screen.dart';
import 'package:p7app/features/user_profile/views/screens/add_edit_experience_screen.dart';
import 'package:p7app/features/user_profile/views/screens/add_edit_technical_skill_screen.dart';
import 'package:p7app/features/user_profile/views/screens/profile_header_edit_screen.dart';
import 'package:p7app/features/user_profile/styles/profile_common_style.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/educations_list_item.dart';
import 'package:p7app/features/user_profile/views/widgets/experience_list_item.dart';
import 'package:p7app/features/user_profile/views/widgets/member_ship_list_item.dart';
import 'package:p7app/features/user_profile/views/widgets/personal_info_widget.dart';
import 'package:p7app/features/user_profile/views/widgets/technical_skill_list_item.dart';
import 'package:p7app/features/user_profile/views/widgets/user_info_list_item.dart';
import 'package:p7app/main_app/api_helpers/url_launcher_helper.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:p7app/main_app/widgets/rectangular_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
    Provider.of<UserProfileViewModel>(context, listen: false).fetchUserData();
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
                                style: Theme.of(context).textTheme.title,
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
          StringUtils.contactInfoText,
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
            text: StringUtils.editProfileText,
            onPressed: () {},
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var titleTextStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    var profileHeaderBackgroundColor = Color(0xff08233A);
    var profileHeaderFontColor = Colors.white;

    var profileImageWidget = Container(
      margin: EdgeInsets.only(bottom: 15, top: 8),
      height: 65,
      width: 65,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(100), boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 5),
      ]),
      child: Consumer<UserProfileViewModel>(
          builder: (context, userProfileViewModel, s) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: userProfileViewModel.userData.personalInfo.image,
              placeholder: (context, _) => Image.asset(
                kDefaultUserImageAsset,
                fit: BoxFit.cover,
              ),
            ));
      }),
    );
    var displayNameWidget = Selector<UserProfileViewModel, String>(
        selector: (_, userProfileViewModel) =>
            userProfileViewModel.userData.personalInfo.fullName,
        builder: (context, String data, _) {
          return Text(
            data ?? "",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: profileHeaderFontColor),
          );
        });
    var socialIconsWidgets = Consumer<UserProfileViewModel>(
      builder: (context, userProfileViewModel, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                  minHeight: 25, maxHeight: 25, minWidth: 25, maxWidth: 25),
              decoration: BoxDecoration(
                  color: AppTheme.facebookColor,
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                onTap: () {
                  var link =
                      userProfileViewModel.userData.personalInfo.facebookId;
                  if (link != null) {
                    if(link.isNotEmpty)
                    UrlLauncherHelper.launchUrl(
                        "https://"+StringUtils.facebookBaseUrl + link);
                  }
                },
                child: Icon(
                  FontAwesomeIcons.facebookF,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Container(
              constraints: BoxConstraints(
                  minHeight: 25, maxHeight: 25, minWidth: 25, maxWidth: 25),
              decoration: BoxDecoration(
                  color: AppTheme.linkedInColor,
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                onTap: () {
                  var link =
                      userProfileViewModel.userData.personalInfo.linkedinId;
                  if (link != null) {
                    if(link.isNotEmpty)
                    UrlLauncherHelper.launchUrl(
                        "https://"+StringUtils.linkedBaseUrl + link);
                  }
                },
                child: Icon(
                  FontAwesomeIcons.linkedinIn,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Container(
              constraints: BoxConstraints(
                  minHeight: 25, maxHeight: 25, minWidth: 25, maxWidth: 25),
              decoration: BoxDecoration(
                  color: AppTheme.twitterColor,
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                onTap: () {
                  var link = userProfileViewModel.userData.personalInfo.twitterId;
                  if (link != null) {
                    if(link.isNotEmpty)
                    UrlLauncherHelper.launchUrl(
                        "https://"+ StringUtils.twitterBaeUrl + link);
                  }
                },
                child: Icon(
                  FontAwesomeIcons.twitter,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ],
        );
      },
    );
    var editButtonHeader = IconButton(
      icon: Icon(
        FontAwesomeIcons.edit,
      ),
      color: profileHeaderFontColor,
      iconSize: 22,
      onPressed: () {
        var userModel =
            Provider.of<UserProfileViewModel>(context, listen: false).userData;
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => ProfileHeaderEditScreen(
                      userModel: userModel,
                    )));
      },
    );
    var userLocationWidget = Row(
      children: <Widget>[
        Icon(
          FontAwesomeIcons.mapMarkerAlt,
          size: 10,
          color: profileHeaderFontColor,
        ),
        SizedBox(
          width: 3,
        ),
        Selector<UserProfileViewModel, String>(
            selector: (_, userProfileViewModel) =>
                userProfileViewModel.userData.personalInfo.currentLocation,
            builder: (context, String data, _) {
              return Text(
                data ?? "",
                style: TextStyle(
                    color: profileHeaderFontColor, fontWeight: FontWeight.w100),
              );
            }),
      ],
    );
    var emailWidget = Selector<UserProfileViewModel, String>(
        selector: (_, userProfileViewModel) =>
            userProfileViewModel.userData.personalInfo.email,
        builder: (context, String data, _) {
          return Text(
            data ?? "",
            style: TextStyle(
              color: profileHeaderFontColor,
              fontSize: 16,
            ),
          );
        });
    var designationWidget = Consumer<UserProfileViewModel>(
        builder: (context, userProfileViewModel, _) {

         var position = userProfileViewModel.userData.personalInfo.currentPosition;
         var company = userProfileViewModel.userData.personalInfo.currentCompany;

      return Column(
        children: <Widget>[
          position == null? SizedBox():
          Text(
            position,
            style: TextStyle(
                fontSize: 18,
                color: profileHeaderFontColor,
                fontWeight: FontWeight.w100),
          ),
          SizedBox(
            height: 5,
          ),
          company == null? SizedBox():
          Text(
            company,
            style: TextStyle(
                color: profileHeaderFontColor, fontWeight: FontWeight.w100),
          ),
        ],
      );

    });
    var aboutMeWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          StringUtils.aboutMeText,
          style: titleTextStyle.apply(color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
//            borderRadius: BorderRadius.circular(5),
            boxShadow: ProfileCommonStyle.boxShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Selector<UserProfileViewModel, String>(
                selector: (_, userProfileViewModel) =>
                    userProfileViewModel.userData.personalInfo.aboutMe ?? "",
                builder: (context, String data, _) {
                  return Text(
                    data,
                    textAlign: TextAlign.left,
                  );
                }),
          ),
        ),
      ],
    );
    var experienceWidget = Consumer<UserProfileViewModel>(
        builder: (context, userProfileViewModel, _) {
      var expList = userProfileViewModel.userData.experienceInfo;
      return UserInfoListItem(
        isInEditMode: isInEditModeExperience,
        onTapEditAction: () {
          isInEditModeExperience = !isInEditModeExperience;
          setState(() {});
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
            isInEditMode: isInEditModeExperience,
            experienceInfoModel: exp,
            onTapEdit: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => AddNewExperienceScreen(
                            index: index,
                            experienceInfoModel: exp,
                          )));
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
        label: StringUtils.educationsText,
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
          );
        }),
      );
    });
    var skillsWidget = Consumer<UserProfileViewModel>(
        builder: (context, userProfileViewModel, _) {
      var list = userProfileViewModel.userData.skillInfo;

      return UserInfoListItem(
        isInEditMode: isInEditModeSkill,
        onTapEditAction: () {
          isInEditModeSkill = !isInEditModeSkill;
          setState(() {});
        },
        icon: FontAwesomeIcons.brain,
        label: StringUtils.professionalSkillText,
        onTapAddNewAction: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => AddEditTechnicalSkill()));
        },
        children: List.generate(list.length, (index) {
          var skill = list[index];
          return TechnicalSkillListItem(
            isInEditMode: isInEditModeSkill,
            skillInfo: skill,
            onTapDelete: () {
              userProfileViewModel.deleteSkillData(skill, index);
            },
            onTapEdit: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => AddEditTechnicalSkill(
                            skillInfo: skill,
                            index: index,
                          )));
            },
          );
        }),
      );
    });
    var personalInfoWidget = PersonalInfoWidget();
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
        label: StringUtils.projectsText,
        onTapAddNewAction: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => EditPortfolio()));
        },
        children: List.generate(list.length, (index) {
          var port = list[index];
          return PortfolioListItemWidget(
            isInEditMode: isInEditModePortfolio,
            portfolioInfo: port,
            onTapEdit: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => EditPortfolio()));
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
        label: StringUtils.certificationsText,
        onTapAddNewAction: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => EditCertification()));
        },
        children: List.generate(list.length, (index) {
          var cer = list[index];
          return CertificationsListItemWidget(
            isInEditMode: isInEditModeCertifications,
            certificationInfo: cer,
            onTapEdit: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => EditCertification()));
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
        label: StringUtils.membershipsText,
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
            onTapDelete: () {
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
        onTapEditAction: () {
          isInEditModeReferences = !isInEditModeReferences;
          setState(() {});
        },
        icon: FontAwesomeIcons.bookReader,
        label: StringUtils.referencesText,
        onTapAddNewAction: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => EditReferenceScreen()));
        },
        children: List.generate(referenceList.length, (index) {
          var ref = referenceList[index];
          return ReferencesListItemWidget(
            isInEditMode: isInEditModeReferences,
            referenceData: ref,
            onTapDelete: () {
              userProfileViewModel.deleteReferenceData(ref, index);
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
        title: Text(StringUtils.profileText),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return Provider.of<UserProfileViewModel>(context, listen: false)
              .fetchUserData();
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Consumer<UserProfileViewModel>(
              builder: (context, userProfileViewModel, child) {
            if (userProfileViewModel.userData == null) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: Loader()),
              );
            }
            return Column(
              children: <Widget>[
                // profile header
                Container(
                  decoration: BoxDecoration(
                    color: profileHeaderBackgroundColor,
                    image: DecorationImage(
                        image: AssetImage(kUserProfileCoverImageAsset),
                        fit: BoxFit.cover),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          profileImageWidget,
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                displayNameWidget,
                                SizedBox(height: 3),
                                emailWidget,
                                SizedBox(height: 3),
                                userLocationWidget,
                              ],
                            ),
                          ),
                          editButtonHeader,
                        ],
                      ),
                      SizedBox(height: 15),
                      socialIconsWidgets,
                      SizedBox(height: 5),
                      designationWidget,
                      SizedBox(height: 8),
                      aboutMeWidget,
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      SizedBox(height: 15),

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
}

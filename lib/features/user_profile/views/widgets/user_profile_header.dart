import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/screens/profile_header_edit_screen.dart';
import 'package:p7app/features/user_profile/views/widgets/user_info_list_item.dart';
import 'package:p7app/main_app/api_helpers/url_launcher_helper.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:provider/provider.dart';
import 'package:p7app/method_extension.dart';

class UserProfileHeader extends StatelessWidget {
  navigateToAboutMeEdit(
    context,
    UserModel userModel,
  ) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ProfileHeaderEditScreen(
                  userModel: userModel,
                  focusAboutMe: true,
                )));
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var profileHeaderBackgroundColor = Color(0xff273F55);
    var profileHeaderFontColor = Colors.white;
    var titleTextStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

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
            imageUrl: userProfileViewModel.userData.personalInfo.profileImage,
            placeholder: (context, _) => Image.asset(
              kDefaultUserImageAsset,
              fit: BoxFit.cover,
            ),
          ),
        );
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
        return Material(
          type: MaterialType.transparency,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                customBorder: CircleBorder(),
                onTap: () {
                  var username =
                      userProfileViewModel.userData.personalInfo.facebookId;
                  if (username.isNotEmptyOrNotNull) {
//                    UrlLauncherHelper.launchFacebookUrl(username);
                    UrlLauncherHelper.launchUrl("https://" +
                        StringResources.facebookBaseUrl +
                        username);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: Material(
                      color: AppTheme.facebookColor,
                      shape: CircleBorder(),
                      child: Icon(
                        FontAwesomeIcons.facebookF,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ),
//            SizedBox(
//              width: 8,
//            ),
              InkWell(
                customBorder: CircleBorder(),
                onTap: () {
                  var link =
                      userProfileViewModel.userData.personalInfo.linkedinId;
                  if (link != null) {
                    if (link.isNotEmpty)
                      UrlLauncherHelper.launchUrl(
                          "https://" + StringResources.linkedBaseUrl + link);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: AppTheme.linkedInColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(
                    FontAwesomeIcons.linkedinIn,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
//            SizedBox(width: 8),
              InkWell(
                customBorder: CircleBorder(),
                onTap: () {
                  var link =
                      userProfileViewModel.userData.personalInfo.twitterId;
                  if (link != null) {
                    if (link.isNotEmpty)
                      UrlLauncherHelper.launchUrl(
                          "https://" + StringResources.twitterBaeUrl + link);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: AppTheme.twitterColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(
                    FontAwesomeIcons.twitter,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    var editButtonHeader = Material(
      type: MaterialType.transparency,
      child: IconButton(
        key: Key('myProfileHeaderEditButton'),
        icon: Icon(
          FontAwesomeIcons.edit,
        ),

        color: profileHeaderFontColor,
        iconSize: 20,
        onPressed: () {
          var userModel =
              Provider.of<UserProfileViewModel>(context, listen: false)
                  .userData;
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => ProfileHeaderEditScreen(
                        userModel: userModel,
                      )));
        },
      ),
    );
    var userLocationWidget = Selector<UserProfileViewModel, String>(
        selector: (_, userProfileViewModel) =>
            userProfileViewModel.userData.personalInfo.currentLocation,
        builder: (context, String data, _) {
          if (data == null) {
            return SizedBox();
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.mapMarkerAlt,
                size: 10,
                color: profileHeaderFontColor,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                data ?? "",
                style: TextStyle(
                    color: profileHeaderFontColor, fontWeight: FontWeight.w100),
              ),
            ],
          );
        });
    var userMobileWidget = Selector<UserProfileViewModel, String>(
        selector: (_, userProfileViewModel) =>
            userProfileViewModel.userData.personalInfo.phone,
        builder: (context, String data, _) {
          if (data == null) {
            return SizedBox();
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.phone_android,
                size: 10,
                color: profileHeaderFontColor,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                data ?? "",
                style: TextStyle(
                    color: profileHeaderFontColor, fontWeight: FontWeight.w100),
              ),
            ],
          );
        });
    var emailWidget = Selector<UserProfileViewModel, String>(
        selector: (_, userProfileViewModel) =>
            userProfileViewModel.userData.personalInfo.email,
        builder: (context, String data, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mail,
                size: 10,
                color: profileHeaderFontColor,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                data ?? "",
                style: TextStyle(
                  color: profileHeaderFontColor,
                ),
              ),
            ],
          );
        });
    var designationWidget = Consumer<UserProfileViewModel>(
        builder: (context, userProfileViewModel, _) {
      var position =
          userProfileViewModel.userData.personalInfo.currentDesignation;
      var company = userProfileViewModel.userData.personalInfo.currentCompany;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          position == null
              ? SizedBox()
              : Text(
                  position,
                  style: TextStyle(
                      color: profileHeaderFontColor,
                      fontWeight: FontWeight.w100),
                ),
          SizedBox(
            height: 5,
          ),
          company == null
              ? SizedBox()
              : Text(
                  company,
                  style: TextStyle(
                      color: profileHeaderFontColor,
                      fontWeight: FontWeight.w100),
                ),
        ],
      );
    });
    var aboutMeWidget = UserInfoListItem(
      icon: FontAwesomeIcons.infoCircle,
      label: StringResources.aboutMeText,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: CommonStyle.boxShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<UserProfileViewModel>(
                builder: (context, userProfileViewModel, _) {
              var aboutMeText =
                  userProfileViewModel.userData.personalInfo.aboutMe ?? "";
              if (aboutMeText.isEmptyOrNull ?? false)
                return FlatButton(
                  onPressed: () {
                    navigateToAboutMeEdit(
                        context, userProfileViewModel.userData);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mode_edit, size: 17, color: Colors.grey),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        StringResources.writeAboutYourself,
                        style: titleTextStyle.apply(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              return HtmlWidget(aboutMeText);
//                  return Text(
//                    data,
//                    textAlign: TextAlign.left,
//                  );
            }),
          ),
        ),
      ],
    );
    return // profile header
        Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: profileHeaderBackgroundColor,
            image: DecorationImage(
                image: AssetImage(kUserProfileCoverImageAsset),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.dstATop)),
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
                        designationWidget,
                        SizedBox(height: 3),

//                                SizedBox(height: 3),
                      ],
                    ),
                  ),
                  editButtonHeader,
                ],
              ),
              SizedBox(height: 15),
              socialIconsWidgets,
              SizedBox(height: 5),
              userMobileWidget,
              SizedBox(height: 5),
              emailWidget,
              SizedBox(height: 5),
              userLocationWidget,
              SizedBox(height: 8),
            ],
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: aboutMeWidget,
        ),
      ],
    );
  }
}

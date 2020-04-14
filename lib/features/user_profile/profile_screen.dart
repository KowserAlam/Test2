import 'package:after_layout/after_layout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/edit_profile_screen.dart';
import 'package:p7app/features/user_profile/providers/user_provider.dart';
import 'package:p7app/features/user_profile/styles/profile_common_style.dart';
import 'package:p7app/features/user_profile/widgets/user_details_info_list_widget.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:p7app/main_app/widgets/rectangular_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).fetchUserData();
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
                      child: Consumer<UserProvider>(
                          builder: (context, userProvider, _) {
                        var user = userProvider.userData;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Spacer(),
                              Divider(),
                              Text(user.email ?? ""),
                              Divider(),
                              Text(
                                user.mobileNumber ?? "",
                                style: Theme.of(context).textTheme.title,
                              ),
                              Divider(),
                              Text(user.personalInfo.currentAddress ?? ""),
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
      margin: EdgeInsets.only(bottom: 15,top: 8),
      height: 65,
      width: 65,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(100), boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 5),
      ]),
      child: Consumer<UserProvider>(builder: (context, userProvider, s) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: AssetImage(
                kDefaultUserImageAsset,
              ),
              image: NetworkImage(userProvider.userData.profilePicUrl),
            ));
      }),
    );
    var displayNameWidget = Selector<UserProvider, String>(
        selector: (_, userProvider) => userProvider.userData.displayName,
        builder: (context, String data, _) {
          return Text(
            data ?? "",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: profileHeaderFontColor),
          );
        });
    var socialIconsWidgets = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(
              minHeight: 25, maxHeight: 25, minWidth: 25, maxWidth: 25),
          decoration: BoxDecoration(
              color: AppTheme.facebookColor,
              borderRadius: BorderRadius.circular(20)),
          child: Icon(
            FontAwesomeIcons.facebookF,
            color: Colors.white,
            size: 15,
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
          child: Icon(
            FontAwesomeIcons.linkedinIn,
            color: Colors.white,
            size: 15,
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
          child: Icon(
            FontAwesomeIcons.twitter,
            color: Colors.white,
            size: 15,
          ),
        ),
      ],
    );
    var editButton = IconButton(
      icon: Icon(
        FontAwesomeIcons.edit,
      ),
      color: profileHeaderFontColor,
      iconSize: 22,
      onPressed: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => EditProfileScreen()));
      },
    );
    var userLocationWidget = Row(
      children: <Widget>[
        Icon(
          FontAwesomeIcons.mapMarkerAlt,
          size: 15,
          color: profileHeaderFontColor,
        ),
        SizedBox(
          width: 3,
        ),
        Selector<UserProvider, String>(
            selector: (_, userProvider) => userProvider.userData.city,
            builder: (context, String data, _) {
              return Text(
                data ?? "",
                style: TextStyle(
                    color: profileHeaderFontColor, fontWeight: FontWeight.w100),
              );
            }),
      ],
    );
    var emailWidget = Selector<UserProvider, String>(
        selector: (_, userProvider) => userProvider.userData.email,
        builder: (context, String data, _) {
          return Text(
            data ?? "",
            style: TextStyle(
              color: profileHeaderFontColor,
              fontSize: 16,
            ),
          );
        });
    var designationWidget = Selector<UserProvider, String>(
        selector: (_, userProvider) => userProvider.userData.designation,
        builder: (context, String data, _) {
          return Column(
            children: <Widget>[
              Text(
                "Jr. Software Engineer",
                style: TextStyle(
                    fontSize: 18,
                    color: profileHeaderFontColor,
                    fontWeight: FontWeight.w100),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Ishraak Solutions",
                style: TextStyle(
                    color: profileHeaderFontColor, fontWeight: FontWeight.w100),
              ),
            ],
          );
        });
    var aboutWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.info_outline,
              size: 18,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              StringUtils.aboutMeText,
              style: titleTextStyle,
            ),
            Spacer(),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.edit,
                  size: 18,
                  color: primaryColor,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: ProfileCommonStyle.boxShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Selector<UserProvider, String>(
                selector: (_, userProvider) => userProvider.userData.about,
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

    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.profileText),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Consumer<UserProvider>(builder: (context, userProvider, child) {
          if (userProvider.userData == null) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Center(child: Loader()),
            );
          }
          return Column(
            children: <Widget>[
              // profile header
              Container(
                height: 200,
                decoration: BoxDecoration(
                    color: profileHeaderBackgroundColor,
                    image: DecorationImage(
                        image: AssetImage(kUserProfileCoverImageAsset),
                        fit: BoxFit.cover),),
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
                              SizedBox(height: 8,),
                              displayNameWidget,
                              SizedBox(height: 3),
                              emailWidget,
                              SizedBox(height: 3),
                              userLocationWidget,
                            ],
                          ),
                        ),
                        editButton,
                      ],
                    ),
                    Spacer(),
                    socialIconsWidgets,
                    SizedBox(
                      height: 5,
                    ),
                    designationWidget,
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    aboutWidget,
                    SizedBox(height: 15),
                    UserDetailsInfoListWidget(),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

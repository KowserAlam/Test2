import 'package:after_layout/after_layout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/edit_profile_screen.dart';
import 'package:p7app/features/user_profile/providers/user_provider.dart';
import 'package:p7app/features/user_profile/widgets/user_details_info_list_widget.dart';
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
            onPressed: () {

            },
          )
        ],
      );

  Widget aboutWidget(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            " " + StringUtils.aboutText,
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 3,
          ),
          Container(
              height: 2, width: 60, color: Theme.of(context).primaryColor),
          SizedBox(
            height: 5,
          ),
          Material(
            color: Theme.of(context).backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Selector<UserProvider, String>(
                  selector: (_, userProvider) => userProvider.userData.about,
                  builder: (context, String data, _) {
                    return Text(
                      data,
                      textAlign: TextAlign.justify,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    );
                  }),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var profileHeaderBackgroundColor = Color(0xff08233A);
    var profileHeaderFontColor = Colors.white;

    var profileImageWidget = Container(
      margin: EdgeInsets.only(bottom: 15),
      height: 70,
      width: 70,
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: profileHeaderFontColor),
          );
        });
    var editButton = IconButton(
      icon: Icon(
        FontAwesomeIcons.edit,
      ),
      color: profileHeaderFontColor,
      iconSize: 22,
      onPressed: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => EditProfileScreen()));
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
    Widget designationWidget = Selector<UserProvider, String>(
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
                height: 250,
                color: profileHeaderBackgroundColor,
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    SizedBox(height: 14),
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
                              SizedBox(height: 5),
                              displayNameWidget,
                              SizedBox(height: 5),
                              emailWidget,
                              SizedBox(height: 5),
                              userLocationWidget,
                            ],
                          ),
                        ),
                        editButton,
                      ],
                    ),
                    Spacer(),
                    designationWidget,
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 10),
              aboutWidget(context),
              SizedBox(height: 15),
              UserDetailsInfoListWidget(),
              SizedBox(height: 5),
            ],
          );
        }),
      ),
    );
  }
}

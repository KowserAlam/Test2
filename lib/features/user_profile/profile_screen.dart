import 'package:after_layout/after_layout.dart';
import 'package:assessment_ishraak/features/user_profile/edit_profile_screen.dart';
import 'package:assessment_ishraak/features/user_profile/providers/user_provider.dart';
import 'package:assessment_ishraak/features/user_profile/widgets/user_details_info_list_widget.dart';
import 'package:assessment_ishraak/main_app/util/const.dart';
import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:assessment_ishraak/main_app/widgets/loader.dart';
import 'package:assessment_ishraak/main_app/widgets/rectangular_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static final String titleText = StringUtils.profileText;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {

    Provider.of<UserProvider>(context,listen: false).fetchUserData();
  }

  Widget profileImageWidget(context) => Center(
        child: Container(
          margin: EdgeInsets.only(bottom: 15),
          height: 170,
          width: 170,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, spreadRadius: 5),
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
        ),
      );

  Widget displayNameWidget(context) => Selector<UserProvider, String>(
      selector: (_, userProvider) => userProvider.userData.displayName,
      builder: (context, String data, _) {
        return Text(
          data ?? "",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      });

  Widget designationWidget(BuildContext context) =>
      Selector<UserProvider, String>(
          selector: (_, userProvider) => userProvider.userData.designation,
          builder: (context, String data, _) {
            return Text(
              data ?? "Software Engineer at Ishraak Solutions",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            );
          });

  Widget userLocationWidget(context) => Row(
        mainAxisAlignment: MediaQuery.of(context).size.width > 720
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.location_on,
            size: 15,
            color: Theme.of(context).unselectedWidgetColor,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Lives in ",
            style: TextStyle(
              color: Theme.of(context).unselectedWidgetColor,
              fontSize: 16,
            ),
          ),
          Selector<UserProvider, String>(
              selector: (_, userProvider) => userProvider.userData.city,
              builder: (context, String data, _) {
                return Text(
                  data ?? "",
                  style: TextStyle(
                      color: Theme.of(context).unselectedWidgetColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                );
              }),
        ],
      );

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
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => EditProfileScreen()));
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

  Widget emailWidget(context) => Selector<UserProvider, String>(
      selector: (_, userProvider) => userProvider.userData.email,
      builder: (context, String data, _) {
        return Text(
          data ?? "",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    bool isTabLayout = MediaQuery.of(context).size.width > 720;
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.profileText),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Consumer<UserProvider>(builder: (context, userProvider, child) {
            if (userProvider.userData == null) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: Loader()),
              );
            }
            return isTabLayout
                ? Column(
                    children: <Widget>[
                      SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 20),
                          profileImageWidget(context),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                displayNameWidget(context),
                                SizedBox(height: 5),
                                designationWidget(context),
                                SizedBox(height: 5),
                                emailWidget(context),
                                SizedBox(height: 5),
                                userContactInfo(context),
                                userLocationWidget(context),
                                SizedBox(height: 10),
                                aboutWidget(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      UserDetailsInfoListWidget(),
                      SizedBox(height: 5),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      SizedBox(height: 16),
                      profileImageWidget(context),
                      SizedBox(height: 5),
                      displayNameWidget(context),
                      SizedBox(height: 5),
                      designationWidget(context),
                      SizedBox(height: 5),
                      userLocationWidget(context),
                      SizedBox(height: 5),
                      userContactInfo(context),
                      SizedBox(height: 5),
                      userProfileViewAndEditWidget(context),
                      SizedBox(height: 10),
                      aboutWidget(context),
                      SizedBox(height: 15),
                      UserDetailsInfoListWidget(),
                      SizedBox(height: 5),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}

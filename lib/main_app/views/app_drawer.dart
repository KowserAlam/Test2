import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/career_advice/view/career_advice_list_screen.dart';
import 'package:p7app/features/company/view/company_list_screen.dart';
import 'package:p7app/features/settings/setings_screen.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/screens/profile_screen.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/views/about_us_screen.dart';
import 'package:p7app/main_app/views/contact_us_screen.dart';
import 'package:p7app/main_app/views/faq_screen.dart';
import 'package:p7app/main_app/views/widgets/app_version_widget_small.dart';
import 'package:p7app/main_app/views/widgets/restart_widget.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  final String routeName;

  AppDrawer({this.routeName});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var selectedIndex = 0;
  var navBarTextColor = Colors.white;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      var upvm = Provider.of<UserProfileViewModel>(context, listen: false);
      var user = upvm?.userData?.personalInfo;
      if (user == null) {
        upvm.getUserData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var headerBackgroundColor = Color(0xff08233A);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: headerBackgroundColor,
              image: DecorationImage(
                  image: AssetImage(kUserProfileCoverImageAsset),
                  fit: BoxFit.cover),
            ),
            child: Consumer<UserProfileViewModel>(builder: (context, upvm, _) {
//              var baseUrl = FlavorConfig.instance.values.baseUrl;
              var user = upvm?.userData?.personalInfo;

              var imageUrl = user?.profileImage ?? kDefaultUserImageNetwork;
              return Container(
                height: 160,
//                  decoration: BoxDecoration(
//                    color: headerBackgroundColor,
//                    image: DecorationImage(
//                        image: AssetImage(kUserProfileCoverImageAsset),
//                        fit: BoxFit.cover),
//                  ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                          ),
                          color: navBarTextColor,
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => SettingsScreen()));
                          },
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.menu),
                            color: navBarTextColor,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    //profile image
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, _) => Image.asset(
                            kDefaultUserImageAsset,
                            fit: BoxFit.cover,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    Text(
                      user?.fullName ?? "",
                      style: TextStyle(color: navBarTextColor, fontSize: 18),
                    ),
                    Text(
                      user?.email ?? "",
                      style: TextStyle(color: navBarTextColor),
                    ),
                  ],
                ),
              );
            }),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ///Home / Jobs on map index = 0
//                  DrawerListWidget(
//                    label: StringUtils.jobsOnMapText,
//                    icon: FontAwesomeIcons.map,
//                    isSelected: false,
//                    onTap: () {
//                      Navigator.pop(context);
//                      Navigator.of(context).push(CupertinoPageRoute(
//                          builder: (context) => OnboardingPage()));
//                    },
//                  ),

//                Divider(height: 1),
//// favorite jobs
//                DrawerListWidget(
//                  label: StringUtils.favoriteJobsText,
//                  icon: FontAwesomeIcons.heart,
//                  isSelected: false,
//                  onTap: () {
//                    Navigator.pop(context);
//                    Navigator.push(
//                        context,
//                        CupertinoPageRoute(
//                            builder: (context) => FavouriteJobListScreen()));
//                  },
//                ),
//                Divider(height: 1),
//
//// applied jobs
//                DrawerListWidget(
//                  label: StringUtils.appliedJobsText,
//                  icon: FontAwesomeIcons.checkCircle,
//                  isSelected: false,
//                  onTap: () {
//                    Navigator.pop(context);
//                    Navigator.push(
//                        context,
//                        CupertinoPageRoute(
//                            builder: (context) => AppliedJobListScreen()));
//                  },
//                ),

                  Divider(height: 1),
                  // company list
                  DrawerListWidget(
                    label: StringResources.companyListAppbarText,
                    icon: FontAwesomeIcons.solidBuilding,
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => CompanyListScreen()));
                    },
                  ),

                  Divider(height: 1),
//
//                DrawerListWidget(
//                  label: StringUtils.skillCheckText,
//                  icon: FontAwesomeIcons.list,
//                  isSelected: false,
//                  onTap: () {
//                    Navigator.pop(context);
//                  },
//                ),
//                Divider(height: 1),

                  ///Profile
                  DrawerListWidget(
                    label: StringResources.myProfileText,
                    icon: FontAwesomeIcons.solidUserCircle,
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => ProfileScreen()));
                    },
                  ),

//                Divider(height: 1,),
//                ///Inbox
//                DrawerListWidget(
//                  label: 'Inbox',
//                  icon: FontAwesomeIcons.facebookMessenger,
//                  isSelected: false,
//                  onTap: () {
//                    Navigator.pop(context);
//                    Navigator.push(
//                        context,
//                        CupertinoPageRoute(
//                            builder: (context) => ChatListScreen()));
//                  },
//                ),

                  Divider(height: 1),
                  //carer advice
                  DrawerListWidget(
                    label: StringResources.careerAdviceText,
                    icon: FontAwesomeIcons.newspaper,
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => CareerAdviceListScreen()));
                    },
                  ),

                  Divider(height: 1),
                  //about us
                  DrawerListWidget(
                    label: StringResources.aboutUsText,
                    icon: FontAwesomeIcons.infoCircle,
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => AboutUsScreen()));
                    },
                  ),
                  Divider(height: 1),
                  //contact us
                  DrawerListWidget(
                    label: StringResources.contactUsText,
                    icon: FontAwesomeIcons.at,
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => ContactUsScreen()));
                    },
                  ),

                  Divider(height: 1),
                  //faq
                  DrawerListWidget(
                    label: StringResources.faqText,
                    icon: FontAwesomeIcons.questionCircle,
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => FAQScreen()));
                    },
                  ),
                  Divider(height: 1),

                  /// ************ sign out
                  DrawerListWidget(
                    label: StringResources.signOutText,
                    icon: FontAwesomeIcons.signOutAlt,
                    isSelected: false,
                    onTap: () {
                      _handleSignOut(context);
                    },
                  ),
                  Divider(height: 1),
                ],
              ),
            ),
          ),
          Center(child: AppVersionWidgetLowerCase())
        ],
      ),
    );
  }
}

_handleSignOut(context) {
//  AuthService.getInstance().then((value) => value.removeUser()).then((value){
//    Provider.of<SettingsViewModel>(context, listen: false).clearAllCachedData();
////    RestartWidget.restartApp(context);
//    locator<RestartNotifier>().restartApp();
//
//  });
  locator<SettingsViewModel>().signOut();
}

/// App Drawer item widget
class DrawerListWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Function onTap;
  final Color color;

  DrawerListWidget({
    @required this.icon,
    @required this.label,
    this.color,
    this.isSelected = false,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var iconColor = color ??
        (isSelected
            ? Theme.of(context).primaryColor
            : (isDarkMode ? Colors.grey[200] : Colors.grey[700]));
    return Material(
      color: isSelected
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Container(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).scaffoldBackgroundColor,
              width: 4,
              height: AppBar().preferredSize.height / 1.2,
            ),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 17,
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: color),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

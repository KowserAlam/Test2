import 'package:cached_network_image/cached_network_image.dart';
import 'package:p7app/features/auth/provider/login_view_model.dart';
import 'package:p7app/features/auth/view/login_screen.dart';
import 'package:p7app/features/company/view/Screens/company_list_screen.dart';
import 'package:p7app/features/config/config_screen.dart';
import 'package:p7app/features/job/view_model/applied_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/favourite_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_filter_widget_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/screens/profile_screen.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/auth_service/auth_user_model.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/main_app/views/about_us_screen.dart';
import 'package:p7app/main_app/views/career_advice.dart';
import 'package:p7app/main_app/views/contact_us_screen.dart';
import 'package:p7app/main_app/views/faq_screen.dart';
import 'package:p7app/main_app/widgets/app_version_widget_small.dart';
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
  Widget build(BuildContext context) {
    var headerBackgroundColor = Color(0xff08233A);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(image: DecorationImage(  image: AssetImage(kUserProfileCoverImageAsset),
                fit: BoxFit.cover)),
            child: FutureBuilder<AuthUserModel>(
                future:
                    AuthService.getInstance().then((value) => value.getUser()),
                builder: (context, snapshot) {
//              var baseUrl = FlavorConfig.instance.values.baseUrl;
                  var user = snapshot.data;
                  var imageUrl =
                      user?.professionalImage ?? kDefaultUserImageNetwork;
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
                                        builder: (context) => ConfigScreen()));
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
//                  ///Home / Jobs index = 0
//                  DrawerListWidget(
//                    label: StringUtils.jobsText,
//                    icon: FontAwesomeIcons.briefcase,
//                    isSelected: false,
//                    onTap: () {
//                      Navigator.pop(context);
////                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
////                        builder: (context) => JobListScreen()));
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
                    label: StringUtils.companyListAppbarText,
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
                    label: StringUtils.profileText,
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
                    label: StringUtils.careerAdviceText,
                    icon: FontAwesomeIcons.newspaper,
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => CareerAdviceScreen()));
                    },
                  ),

                  Divider(height: 1),
                  //about us
                  DrawerListWidget(
                    label: StringUtils.aboutUsText,
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
                    label: StringUtils.contactUsText,
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
                    label: StringUtils.faqText,
                    icon: FontAwesomeIcons.questionCircle,
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (context) => FAQScreen()));
                    },
                  ),
                  Divider(height: 1),

                  /// ************ sign out
                  DrawerListWidget(
                    label: StringUtils.signOutText,
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
  Provider.of<LoginViewModel>(context, listen: false).signOut();
  Provider.of<JobListViewModel>(context, listen: false).resetState();
  Provider.of<FavouriteJobListViewModel>(context, listen: false).resetState();
  Provider.of<AppliedJobListViewModel>(context, listen: false).resetState();
  Provider.of<JobListFilterWidgetViewModel>(context, listen: false)
      .resetState();
  Provider.of<UserProfileViewModel>(context, listen: false).resetState();

  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => LoginScreen()), (_) => false);
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
      child: Row(
        children: <Widget>[
          Container(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
            width: 4,
            height: AppBar().preferredSize.height,
          ),
          Expanded(
            child: ListTile(
              onTap: onTap,
              leading: Icon(
                icon,
                color: iconColor,
              ),
              title: Text(
                label,
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold, color: color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

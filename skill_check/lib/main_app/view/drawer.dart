import 'package:skill_check/features/auth/provider/login_view_model.dart';
import 'package:skill_check/features/auth/view/login_screen.dart';
import 'package:skill_check/features/config/config_screen.dart';
import 'package:skill_check/features/enrolled_exam_list_screen/view/enrolled_exam_list_screen.dart';
import 'package:skill_check/features/featured_exam_screen/views/featured_exams_screen.dart';
import 'package:skill_check/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:skill_check/features/recent_exam/view/recent_exam_list_screen.dart';
import 'package:skill_check/features/user_profile/profile_screen.dart';
import 'package:skill_check/main_app/util/const.dart';
import 'package:skill_check/main_app/util/strings_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),

        Consumer<DashboardScreenProvider>(
            builder: (context, dashboardScreenProvider, child) {
          return ListTile(
            leading: Container(
              padding: const EdgeInsets.all(4.0),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipRRect(
                child: Consumer<DashboardScreenProvider>(
                    builder: (context, dashboardScreenProvider, child) {
                  return FadeInImage(
                    placeholder: AssetImage(kDefaultUserImageAsset),
                    image: NetworkImage(
                      dashboardScreenProvider.dashBoardData != null
                          ? dashboardScreenProvider
                              .dashBoardData.user.profilePicUrl
                          : kDefaultUserImageNetwork,
                    ),
                    fit: BoxFit.cover,
                  );
                }),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            title: Text(
              dashboardScreenProvider.dashBoardData != null
                  ? "${dashboardScreenProvider.dashBoardData.user.name}"
                  : "",
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              dashboardScreenProvider.dashBoardData != null
                  ? "${dashboardScreenProvider.dashBoardData.user.email}"
                  : "",
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Container(
              child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
        }),

        /// top menu bar icon for pop the app Drawer

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ///DashBoard

                DrawerListWidget(
                  label: StringUtils.dashBoardText,
                  icon: Icons.dashboard,
                  isSelected: true,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Divider(
                  height: 1,
                ),

                ///Enrolled Exams

                DrawerListWidget(
                  label: StringUtils.enrolledExamsText,
                  icon: FontAwesomeIcons.solidBookmark,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EnrolledExamScreen()));
                  },
                ),
                Divider(
                  height: 1,
                ),

                ///RecentExamScreen

                DrawerListWidget(
                  label: StringUtils.recentExamsText,
                  icon: FontAwesomeIcons.history,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecentExamScreen()));
                  },
                ),
                Divider(
                  height: 1,
                ),

                ///FeaturedExamsScreen
                DrawerListWidget(
                  label: StringUtils.featuredExamsText,
                  icon: FontAwesomeIcons.fireAlt,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeaturedExamsScreen()));
                  },
                ),
                Divider(
                  height: 1,
                ),

                ///Profile
                DrawerListWidget(
                  label: StringUtils.profileText,
                  icon: FontAwesomeIcons.userTie,
                  isSelected: false,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ProfileScreen()));
                  },
                ),

                Divider(
                  height: 1,
                ),

                ///Index not required !
                ///Settings
                DrawerListWidget(
                  label: StringUtils.settingsText,
                  icon: FontAwesomeIcons.cog,
                  isSelected: false,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ConfigScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
        ),

        /// ************ sign out
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: DrawerListWidget(
            color: Colors.redAccent,
            label: StringUtils.signOutText,
            icon: FontAwesomeIcons.signOutAlt,
            isSelected: false,
            onTap: () {
              Provider.of<LoginViewModel>(context,listen: false).signOut();
              Provider.of<DashboardScreenProvider>(context,listen: false).resetState();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (_) => false);
            },
          ),
        ),
      ],
    );
  }
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
                color: color ??
                    (isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).iconTheme.color),
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

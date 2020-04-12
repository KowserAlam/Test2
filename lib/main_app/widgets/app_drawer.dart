import 'package:p7app/features/auth/provider/login_view_model.dart';
import 'package:p7app/features/auth/view/login_screen.dart';
import 'package:p7app/features/config/config_screen.dart';
import 'package:p7app/features/job/view/job_list_screen.dart';
import 'package:p7app/features/user_profile/profile_screen.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  final String routeName ;

  AppDrawer({this.routeName});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),

        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(4.0),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
              child: FadeInImage(
                placeholder: AssetImage(kDefaultUserImageAsset),
                image: NetworkImage(kDefaultUserImageNetwork,),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          title: Text(
            "",
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
         "",
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
        ),

        /// top menu bar icon for pop the app Drawer

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                ///Home / Jobs index = 0

                DrawerListWidget(
                  label: StringUtils.homText,
                  icon: Icons.home,
                  isSelected: widget.routeName == 'job_list',
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacement(CupertinoPageRoute(builder: (context)=>JobListScreen()));

                  },
                ),

                Divider(
                  height: 1
                ),

                ///Profile index = 4
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

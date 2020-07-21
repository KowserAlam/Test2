import 'package:flutter/cupertino.dart';
import 'package:p7app/features/auth/view/passworrd_change_screen.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/main_app/repositories/app_info_repository.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/views/widgets/app_logo.dart';
import 'package:p7app/main_app/views/widgets/common_prompt_dialog.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String appVersion = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.settingsText),
      ),
      body: ListView(
        children: <Widget>[
//          ListTile(
//            leading: Icon(
//              FontAwesomeIcons.solidMoon,
//              size: 22,
//            ),
//            title: Text(StringUtils.darkModeText),
//            trailing: Consumer<ConfigProvider>(
//              builder: (context, configProvider,s) {
//                return Switch(
//                  onChanged: (bool value) {
//                    configProvider.toggleThemeChangeEvent();
//                  },
//                  value: configProvider.isDarkModeOn,
//                );
//              }
//            ),
//          ),
//          Divider(height: 2,),

          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ChangePasswordScreen()));
            },
            leading: Icon(
              Icons.lock_open,
            ),
            title: Text(StringResources.changePassword),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => LicensePage(
                            applicationLegalese: "Copyright © 2020 Job Search",
                            applicationVersion: appVersion,
                            applicationIcon: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(kDefaultLogoSq))),
                            ),
                          )));
            },
            leading: Icon(
              Icons.featured_play_list,
            ),
            title: Text(StringResources.licenses),
          ),
          ListTile(
            onTap: () {_showClearCacheDialog();},
            leading: Icon(
              FontAwesomeIcons.eraser,
              size: 20,
            ),
            title: Text(StringResources.clearCachedData),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.infoCircle,
              size: 22,
            ),
            title: FutureBuilder(
              future: AppInfoRepository().getAppVersion(),
              builder: (c, snapshot) {
                appVersion = snapshot.data ?? "";
                return Text(
                  snapshot.hasData ? "Version: ${snapshot.data}" : "",
                  style: TextStyle(color: Colors.grey),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  _showClearCacheDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CommonPromptDialog(
            onAccept: () {
              locator<SettingsViewModel>().clearAllCachedData();
              Navigator.pop(context);
            },
            onCancel: () {
              Navigator.pop(context);
            }, titleText: StringResources.doYouWantToClearAllCacheText,
          );
        });
  }
}

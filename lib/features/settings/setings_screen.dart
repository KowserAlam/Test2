import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:p7app/features/auth/view/passworrd_change_screen.dart';
import 'package:p7app/features/auth/view_models/login_view_model.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/repositories/app_info_repository.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/views/widgets/app_logo.dart';
import 'package:p7app/main_app/views/widgets/common_prompt_dialog.dart';
import 'package:p7app/main_app/views/widgets/restart_widget.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String appVersion = "";
  var divider = Divider(
    height: 1,
  );

  @override
  Widget build(BuildContext context) {
    var darkMode = ListTile(
      leading: Icon(
        FontAwesomeIcons.solidMoon,
        size: 22,
      ),
      title: Text(StringResources.darkModeText),
      trailing:
          Consumer<SettingsViewModel>(builder: (context, configProvider, s) {
        return Switch(
          onChanged: (bool value) {
            configProvider.toggleThemeChangeEvent();
          },
          value: configProvider.isDarkModeOn,
        );
      }),
    );
    var changePassword = ListTile(
      onTap: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => ChangePasswordScreen()));
      },
//            leading: Icon(
//              Icons.lock_open,
//            ),
      title: Text(StringResources.changePassword),
      subtitle: Text(StringResources.changePasswordInfoText),
//            trailing: Icon(Icons.chevron_right),
    );
    var clearCache = ListTile(
      onTap: () {
        _showClearCacheDialog();
      },
      title: Text(StringResources.clearCachedData),
      subtitle: Text(StringResources.clearCachedDataInfo),
    );
    var licenses = ListTile(
      trailing: Icon(Icons.chevron_right),
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
//            leading: Icon(
//              Icons.featured_play_list,
//            ),
      subtitle: Text("Show licences"),
      title: Text(StringResources.licenses),
    );
    var version = FutureBuilder<PackageInfo>(
      future: AppInfoRepository().getAppPackageInfo(),
      builder: (c, AsyncSnapshot<PackageInfo> snapshot) {
        appVersion = snapshot.data?.version ?? "";
        var buildNumber = snapshot.data?.buildNumber ?? "";
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            snapshot.hasData ? "VERSION: $appVersion.$buildNumber" : "",
            style: TextStyle(color: Colors.grey[600]),
          ),
        );
      },
    );
    var signOut = InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          StringResources.signOutText,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
      onTap: () {
        _showSignOutDialog();
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.settingsText),
      ),
      body: ListView(
        children: <Widget>[
          changePassword,
          divider,
          clearCache,
          divider,
          signOut,
          divider,
          version,
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
              locator<SettingsViewModel>().clearAllCachedData().then((value) {
                BotToast.showText(text: StringResources.clearedText);
              });
              Navigator.pop(context);
            },
            onCancel: () {
              Navigator.pop(context);
            },
            titleText: StringResources.doYouWantToClearAllCacheText,
          );
        });
  }

  _showSignOutDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CommonPromptDialog(
            onAccept: () {
              Navigator.pop(context);
              AuthService.getInstance()
                  .then((value) => value.removeUser())
                  .then((value) {
                locator<SettingsViewModel>().clearAllCachedData();
                Cache.clear();
                RestartWidget.restartApp(context);
              });
            },
            onCancel: () {
              Navigator.pop(context);
            },
            titleText: StringResources.doYouWantToSignOutText,
          );
        });
  }
}

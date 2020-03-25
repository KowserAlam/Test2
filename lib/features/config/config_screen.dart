
import 'package:p7app/features/config/config_provider.dart';
import 'package:p7app/main_app/repositories/app_info_repository.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.settingsText),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(
              FontAwesomeIcons.solidMoon,
              size: 22,
            ),
            title: Text(StringUtils.darkModeText),
            trailing: Consumer<ConfigProvider>(
              builder: (context, configProvider,s) {
                return Switch(
                  onChanged: (bool value) {
                    configProvider.toggleThemeChangeEvent();
                  },
                  value: configProvider.isDarkModeOn,
                );
              }
            ),
          ),
          Divider(height: 2,),

          ListTile(
            leading: Icon(
              FontAwesomeIcons.infoCircle,
              size: 22,
            ),
            title: FutureBuilder(
              future: AppInfoRepository().getAppVersion(),
              builder: (c,snapshot)=> Text(snapshot.hasData?"Version: ${snapshot.data}":"",style: TextStyle(color: Colors.grey),),
            ),
          )
        ],
      ),
    );
  }
}

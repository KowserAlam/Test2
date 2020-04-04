import 'dart:convert';

import 'package:p7app/features/home_screen/views/dashboard_screen.dart';
import 'package:p7app/features/home_screen/views/job_list_screen.dart';
import 'package:p7app/main_app/auth_service/auth_user_model.dart';
import 'package:p7app/features/auth/view/login_screen.dart';
import 'package:p7app/main_app/util/json_keys.dart';
import 'package:p7app/main_app/util/const.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:p7app/main_app/util/comon_styles.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
//    ApiHelper apiHelper = ApiHelper();
//    apiHelper.checkInternetConnectivity();

    getAuthStatus().then((AuthUserModel user) {
      if (user != null) {
        Future.delayed(Duration(seconds: 1)).then((_) {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => JobListScreen()),
              (Route<dynamic> route) => false);
        });
      } else {
        Future.delayed(Duration(seconds: 2)).then((_) {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false);
        });
      }
    });

    super.initState();
  }

  Future<AuthUserModel> getAuthStatus() async {
    var prf = await SharedPreferences.getInstance();
    var res = prf.getString(JsonKeys.user);
    print("User: $res");
    return res != null ? AuthUserModel.fromJson(jsonDecode(res)) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 300,
          child: Column(
            children: <Widget>[
              Hero(
                  tag: kDefaultLogo,
                  child: Image(
                    image: AssetImage(kDefaultLogo),
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  StringUtils.appName,
                  style: kTitleStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Loader(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

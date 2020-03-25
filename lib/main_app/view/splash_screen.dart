import 'dart:convert';

import 'package:assessment_ishraak/features/home_screen/views/dashboard_screen.dart';
import 'package:assessment_ishraak/features/home_screen/views/home.dart';
import 'package:assessment_ishraak/main_app/auth_service/auth_user_model.dart';
import 'package:assessment_ishraak/features/auth/view/login_screen.dart';
import 'package:assessment_ishraak/main_app/util/json_keys.dart';
import 'package:assessment_ishraak/main_app/util/const.dart';
import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:assessment_ishraak/main_app/util/cosnt_style.dart';
import 'package:assessment_ishraak/main_app/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
//    ApiHelper apiHelper = ApiHelper();
//    apiHelper.checkInternetConnectivity();

    getAuthStatus().then((AuthUserModel user) {
      if (user != null) {
        Future.delayed(Duration(seconds: 2)).then((_) {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => DashBoardScreen()),
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

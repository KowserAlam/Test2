import 'dart:convert';
import 'package:p7app/features/job/view/job_list_screen.dart';
import 'package:p7app/main_app/auth_service/auth_user_model.dart';
import 'package:p7app/features/auth/view/login_screen.dart';
import 'package:p7app/main_app/repositories/app_info_repository.dart';
import 'package:p7app/main_app/resource/json_keys.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/app_theme/comon_styles.dart';
import 'package:p7app/main_app/widgets/app_version_widget_small.dart';
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
        Future.delayed(Duration(seconds: 2)).then((_) {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => JobListScreen()),
              (Route<dynamic> route) => false);
        });
      } else {
        Future.delayed(Duration(seconds: 1)).then((_) {
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

  var appLogoText = Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 170,
        child: Hero(tag: kDefaultLogo,child: Image.asset(kDefaultLogo,fit: BoxFit.cover,)),
      ),
      Container(
        width: 250,
        child: Image.asset(kDefaultLogoText,fit: BoxFit.cover,),
      ),
    ],
  );

  var ishraakLogo = Image.asset(kIshraakLogo,fit: BoxFit.cover,);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var appLogoText = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width*0.3,
          child: Hero(tag: kDefaultLogo,child: Image.asset(kDefaultLogo,fit: BoxFit.cover,)),
        ),
        Container(
          width: width*0.5,
          child: Image.asset(kDefaultLogoText,fit: BoxFit.cover,),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(),
            SizedBox(),
            SizedBox(),
            appLogoText,
            SizedBox(),
            Container(width: 150,child: ishraakLogo,),
            AppVersionWidgetLowerCase()
          ],
        ),
      ),
    );
  }
}

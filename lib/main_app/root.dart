import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:p7app/features/job/view/job_list_screen.dart';
import 'package:p7app/features/onboarding_page/onboarding_page.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/auth_service/auth_user_model.dart';
import 'package:p7app/features/auth/view/login_screen.dart';
import 'package:p7app/main_app/home.dart';
import 'package:p7app/main_app/push_notification_service/push_notification_service.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/util/local_storage.dart';
import 'package:p7app/main_app/util/token_refresh_scheduler.dart';
import 'package:p7app/main_app/views/widgets/app_version_widget_small.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  final bool showDummyLoadingTime;

  Root({this.showDummyLoadingTime = false});

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    var authService = await AuthService.getInstance();
//    authService.refreshToken();
    if (authService.isAccessTokenValid()) {
      debugPrint("user: ${authService.getUser()}");

      _naveGateToNextScreen(showDummyLoading: widget.showDummyLoadingTime);
    } else {
      bool isSuccess = await authService.refreshToken();
      if (isSuccess) {
        _naveGateToNextScreen();
      } else {
        _navigateToLoginScreen();
        authService.removeUser();
      }
    }
  }

  _navigateToLoginScreen() {
    Future.delayed(Duration(seconds: 1)).then((_) {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
    });
  }

  _naveGateToNextScreen({bool showDummyLoading = false}) {
    _setupPushNotification();
    _initUserdata();

    Future.delayed(Duration(seconds: showDummyLoading ? 0 : 2)).then((_) async {
      if (await shouldShowOnBoardingScreens()) {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => OnboardingPage()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false);
      }
    });
  }

  _setupPushNotification() {
    var pushNotificationService = locator<PushNotificationService>();
  }

  _initUserdata() {
    Provider.of<UserProfileViewModel>(context, listen: false).getUserData();
  }

  Future<bool> shouldShowOnBoardingScreens() async {
    var _storage = await LocalStorageService.getInstance();
    var val = _storage.getBool("showIntro");
    if (val == null) return true;

    return val;
  }

  Future<AuthUserModel> getAuthStatus() async {
    AuthUserModel user =
        await AuthService.getInstance().then((value) => value.getUser());

    if (user != null) {
      Logger().i(user.toJson());
    } else {
      debugPrint("User: $user");
    }
    return user;
  }

  var appLogoText = Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 170,
        child: Hero(
            tag: kDefaultLogo,
            child: Image.asset(
              kDefaultLogo,
              fit: BoxFit.cover,
            )),
      ),
      Container(
        width: 250,
        child: Image.asset(
          kDefaultLogoText,
          fit: BoxFit.cover,
        ),
      ),
    ],
  );

  var ishraakLogo = Image.asset(
    kIshraakLogo,
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var appLogoText = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width * 0.3,
          child: Hero(
              tag: kDefaultLogo,
              child: Image.asset(
                kDefaultLogo,
                fit: BoxFit.cover,
              )),
        ),
        Container(
          width: width * 0.5,
          child: Image.asset(
            kDefaultLogoText,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light
              .copyWith(statusBarColor: Theme.of(context).primaryColor),
          child: widget.showDummyLoadingTime
              ? Center(
                  child: Loader(),
                )
              : Container(
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
                      Container(
                        width: 150,
                        child: ishraakLogo,
                      ),
                      AppVersionWidgetLowerCase()
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:p7app/features/auth/view/sign_in_screen.dart';
import 'package:p7app/features/company/view/company_list_screen.dart';
import 'package:p7app/features/dashboard/view/dash_board.dart';
import 'package:p7app/features/job/view/all_job_list_screen.dart';
import 'package:p7app/features/job/view/job_details_screen.dart';
import 'package:p7app/features/job/view/jobs_screen.dart';
import 'package:p7app/features/job/view_model/all_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/job_screen_view_model.dart';
import 'package:p7app/features/messaging/view/message_screen.dart';
import 'package:p7app/features/notification/repositories/live_update_service.dart';
import 'package:p7app/features/notification/view_models/notificaion_view_model.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/screens/profile_screen.dart';
import 'package:p7app/main_app/auth_service/auth_view_model.dart';
import 'package:p7app/main_app/flavour/flavor_banner.dart';
import 'package:p7app/main_app/push_notification_service/push_notification_service.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/device_info_util.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/util/logger_helper.dart';
import 'package:p7app/main_app/util/token_refresh_scheduler.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;

class Home extends StatefulWidget {
  Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NotificationViewModel _notiController = Get.put(NotificationViewModel());
  var _paeViewController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    TokenRefreshScheduler.getInstance();
    _init();
    super.initState();
  }

  _init() {
    locator<PushNotificationService>().fcmSubscribeNews();
    Future.delayed(Duration.zero).then((value) {
      var authVM = Provider.of<AuthViewModel>(context, listen: false);
      if (authVM.isLoggerIn) {
        locator<LiveUpdateService>().initSocket(context);
        locator<PushNotificationService>().initPush();
        _initUserdata();
      }
    });
    DeviceInfoUtil().getDeviceID();
    DeviceInfoUtil().getDeviceInfo();
    initUniLinks();
  }

  _initUserdata() {
    Provider.of<UserProfileViewModel>(context, listen: false).getUserData();
  }

  Future<Null> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      String initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.

      if (initialLink != null) {
        if (initialLink.contains('job-list')) {
          Get.to(AllJobListScreen());
        }
        if (initialLink.contains('job-detail/')) {
          /// ./adb shell 'am start -W -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "applink://jobxprss.com/job-detail/slug"'
          /// applink://jobxprss.com/job-detail/business-development-executive-a7e22381
          var index = initialLink.indexOf('job-detail/');
          var slug = initialLink.substring(index+11);
          logger.i({"slug": slug});
          Get.to(JobDetailsScreen(slug: slug));
        }
        // BotToast.showText(text: "$initialLink");

      }
      logger.i({"initialLink": initialLink});
    } on PlatformException catch (e) {
      logger.e(e);
      // BotToast.showText(text: "$e");
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  @override
  Widget build(BuildContext context) {
    var authVM = Provider.of<AuthViewModel>(context);
    bool isLoggedIn = authVM.isLoggerIn;

    var bottomNavBar = BottomNavigationBar(
//        selectedItemColor: Theme.of(context).primaryColor,
//        unselectedItemColor: Colors.grey,

        onTap: (int index) async {
          if (currentIndex != index) {
            // // animation
            // var offset = 0;
            // if (index > currentIndex) {
            //   offset = 100;
            // } else if(index < currentIndex) {
            //   offset = -100;
            // }
            // await _paeViewController.animateTo(
            //     _paeViewController.offset + offset,
            //     duration: const Duration(milliseconds: 50),
            //     curve: Curves.easeInOut);

            _paeViewController.jumpToPage(index);
          }

//
//          _paeViewController.animateToPage(index,
//              duration: const Duration(milliseconds: 400),
//              curve: Curves.easeInOut);
        },
        currentIndex: currentIndex,
        iconSize: 17,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.grey[800],
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        selectedFontSize: 10,
        unselectedFontSize: 10,
        elevation: 4,
        type: BottomNavigationBarType.fixed,
        items: [
          // dashboard
          BottomNavigationBarItem(
              icon: Padding(
                key: Key('bottomNavigationBarDashboard'),
                padding: const EdgeInsets.only(
                  bottom: 3,
                ),
                child: Icon(
                  FontAwesomeIcons.home,
                ),
              ),
              title: Text(isLoggedIn
                  ? StringResources.dashBoardText
                  : StringResources.homText)),
          //jobs
          BottomNavigationBarItem(
              icon: Padding(
                key: Key('bottomNavigationBarJobs'),
                padding: const EdgeInsets.only(
                  bottom: 3,
                ),
                child: Icon(
                  FontAwesomeIcons.briefcase,
                ),
              ),
              title: Text(StringResources.jobsText)),
          BottomNavigationBarItem(
              icon: Padding(
                key: Key('bottomNavigationBarCompany'),
                padding: const EdgeInsets.only(bottom: 5),
                child: Icon(
                  FontAwesomeIcons.solidBuilding,
                ),
              ),
              title: Text(StringResources.companyListAppbarText)),
          //notifications
          BottomNavigationBarItem(
              icon: Padding(
                key: Key('bottomNavigationBarMessages'),
                padding: const EdgeInsets.only(bottom: 5),
                child: Icon(
                  FontAwesomeIcons.solidComments,
                ),
              ),
              title: Text(StringResources.messagesText)),
          // profile
          BottomNavigationBarItem(
              icon: Padding(
                key: Key('bottomNavigationBarMyProfile'),
                padding: const EdgeInsets.only(bottom: 5),
                child: Icon(
                  FontAwesomeIcons.solidUserCircle,
                ),
              ),
              title: Text(StringResources.myProfileText)),
        ]);

    return WillPopScope(
      onWillPop: () async {
        if (currentIndex == 0)
          return true;
        else {
          _paeViewController.animateToPage(0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
          return false;
        }
      },
      child: FlavorBanner(
        child: Scaffold(
          bottomNavigationBar: bottomNavBar,
          body: PageView(
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            controller: _paeViewController,
            children: <Widget>[
              DashBoard(
                onTapSearch: () {
                  _paeViewController.animateToPage(1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                  Provider.of<JobScreenViewModel>(context, listen: false)
                      .onChange(0);
                  Provider.of<AllJobListViewModel>(context, listen: false)
                      .enableSearchMode();
                },
                onTapApplied: () {
                  _paeViewController.animateToPage(1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                  Provider.of<JobScreenViewModel>(context, listen: false)
                      .onChange(1);
                },
                onTapFavourite: () {
                  _paeViewController.animateToPage(1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                  Provider.of<JobScreenViewModel>(context, listen: false)
                      .onChange(2);
                },
                onTapRecentJobs: () {
                  _paeViewController.animateToPage(1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                  Provider.of<JobScreenViewModel>(context, listen: false)
                      .onChange(0);
                },
                onTapFeaturedCompany: () {
                  _paeViewController.animateToPage(2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                },
              ),
              JobsScreen(),
//              AppliedJobListScreen(),
//              FavouriteJobListScreen(),
              CompanyListScreen(),
              MessageScreen(),
              ProfileScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

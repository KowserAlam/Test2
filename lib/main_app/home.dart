import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/notification/views/notification_screen.dart';
import 'package:p7app/features/dashboard/view/dash_board.dart';
import 'package:p7app/features/job/view/applied_job_list_screen.dart';
import 'package:p7app/features/job/view/favourite_job_list_screen.dart';
import 'package:p7app/features/job/view/job_list_screen.dart';
import 'package:p7app/main_app/flavour/flavor_banner.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/token_refresh_scheduler.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _paeViewController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    TokenRefreshScheduler.getInstance();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var bottomNavBar = BottomNavigationBar(
//        selectedItemColor: Theme.of(context).primaryColor,
//        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          _paeViewController.animateToPage(index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        },
        currentIndex: currentIndex,
        iconSize: 17,
        selectedItemColor: Theme.of(context).accentColor,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        items: [

          // dashboard
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                  bottom: 3,
                ),
                child: Icon(
                  FontAwesomeIcons.home,
                ),
              ),
              title: Text(StringResources.dashBoardText)),
          //jobs
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                  bottom: 3,
                ),
                child: Icon(
                  FontAwesomeIcons.briefcase,
                ),
              ),
              title: Text(StringResources.jobsText)),
          //applied
          BottomNavigationBarItem(
              icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(FontAwesomeIcons.solidCheckSquare)),
              title: Text(StringResources.appliedText)),
          // favourite
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Icon(FontAwesomeIcons.solidHeart),
              ),
              title: Text(StringResources.favoriteText)),
          //notifications
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Icon(FontAwesomeIcons.solidBell),
              ),
              title: Text(StringResources.notificationsText)),
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
                onTapApplied: () {
                  _paeViewController.animateToPage(2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                },
                onTapFavourite: () {
                  _paeViewController.animateToPage(3,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                },
              ),
              JobListScreen(),
              AppliedJobListScreen(),
              FavouriteJobListScreen(),
              NotificationScreen(),
            ],
          ),
        ),
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/view/applied_job_list_screen.dart';
import 'package:p7app/features/job/view/favourite_job_list_screen.dart';
import 'package:p7app/features/job/view/job_list_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _paeViewController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {


    var bottomNavBar = BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
//        selectedItemColor: Theme.of(context).primaryColor,
//        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          _paeViewController.animateToPage(index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.briefcase,
              ),
              title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.checkCircle), title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.heart), title: Text("")),
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
            JobListScreen(),
            AppliedJobListScreen(),
            FavouriteJobListScreen(),
          ],
        ),
      ),
    );
  }
}

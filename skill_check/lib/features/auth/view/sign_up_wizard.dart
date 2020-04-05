
import 'package:skill_check/features/home_screen/views/dashboard_screen.dart';
import 'package:skill_check/features/user_profile/widgets/change_image_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class SignUpWizard extends StatefulWidget {
  @override
  _SignUpWizardState createState() => _SignUpWizardState();
}

class _SignUpWizardState extends State<SignUpWizard> {
  PageController _pageController = PageController();
  var _valueNotifier =  ValueNotifier<int>(0);
  int index = 0;
  int length = 3;

  @override
  Widget build(BuildContext context) {
    bool isLastIndex = index == length - 1;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RawMaterialButton(
        fillColor: Theme.of(context).primaryColor.withOpacity(0.2),
        elevation: 0,
        splashColor: Theme.of(context).primaryColor.withOpacity(0.5),
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        constraints: BoxConstraints(
            maxHeight: 60, maxWidth: 60, minHeight: 60, minWidth: 60),
        child: Icon(
            isLastIndex
                ? FontAwesomeIcons.check
                : FontAwesomeIcons.chevronRight,
            color: Theme.of(context).primaryColor),
        onPressed: () {
          if (isLastIndex) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => DashBoardScreen()),
                (_) => false);
          } else {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
          }
        },
      ),
      body: _pageView(),
    );
  }




  _pageView() {
    return Stack(
      children: <Widget>[
        PageView(
          physics: BouncingScrollPhysics(),
          onPageChanged: (i) {
            _valueNotifier.value = i;
            setState(() {
              index = i;
            });
          },
          pageSnapping: true,
          controller: _pageController,
          children: <Widget>[
            ChangeProfileImage(),
            setInformation(),
            setBio(),
          ],
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: MediaQuery.of(context).size.height/8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CirclePageIndicator(
              dotColor: Theme.of(context).primaryColor.withOpacity(0.25),
              selectedDotColor: Theme.of(context).primaryColor,
              selectedSize: 10,
              itemCount: length,
              currentPageNotifier: _valueNotifier,
            ),
          ),
        )
      ],
    );
  }



  Widget setInformation() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Update your basic info !",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          TextField(
            style: Theme.of(context).textTheme.title,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "eg. Jhon Smith",
              labelText: "Full Name",
              labelStyle: Theme.of(context).textTheme.title,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            style: Theme.of(context).textTheme.title,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelStyle: Theme.of(context).textTheme.title,
              hintText: "eg. +8817XXXXXXX",
              labelText: "Phone",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            style: Theme.of(context).textTheme.title,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText:
                  "House 76 (Level 4), Road 4, Block B, Niketan Gulshan 1, Dhaka 1212, Bangladesh",
              labelText: "Address",
            ),
          ),
        ],
      ),
    );
  }

  Widget setBio() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Say Something about you !",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          TextField(
            style: Theme.of(context).textTheme.title,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                hintText: "Type here", border: InputBorder.none),
          ),
        ],
      ),
    );
  }
}



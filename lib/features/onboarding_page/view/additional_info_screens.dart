import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/onboarding_page/onboarding_page.dart';
import 'package:p7app/features/onboarding_page/slide_dots.dart';
import 'package:p7app/features/onboarding_page/view/widgets/job_seeking_status.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';

class AdditionalInfoScreens extends StatefulWidget {
  AdditionalInfoScreens({Key key}) : super(key: key);

  @override
  _AdditionalInfoScreensState createState() => _AdditionalInfoScreensState();
}

class _AdditionalInfoScreensState extends State<AdditionalInfoScreens> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  var _pages = [
    JobSeekingStatus(),
    JobSeekingStatus(),
  ];

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
         physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return _pages[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pages.length,
                    (index) => SlideDots(index == _currentPage))),
          ),
          SizedBox(height: 20,),
          _currentPage == _pages.length-1
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                  builder: (context) => OnboardingPage()),
                              (_) => false);
                        },
                        child: Center(
                          child: Text(
                            StringResources.continueText,
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                  builder: (context) => OnboardingPage()),
                              (_) => false);
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        )),
                  ),
                ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/onboarding_page/view/onboarding_page.dart';
import 'package:p7app/features/onboarding_page/view/widgets/select_location.dart';
import 'package:p7app/features/onboarding_page/view/widgets/select_top_skill.dart';
import 'package:p7app/features/onboarding_page/view/widgets/slide_dots.dart';
import 'package:p7app/features/onboarding_page/view/widgets/job_seeking_status.dart';
import 'package:p7app/features/onboarding_page/view_models/additional_info_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:provider/provider.dart';

class AdditionalInfoScreens extends StatefulWidget {
  final additionalInfoViewModel = AdditionalInfoViewModel();

  AdditionalInfoScreens({Key key}) : super(key: key);

  @override
  _AdditionalInfoScreensState createState() => _AdditionalInfoScreensState();
}

class _AdditionalInfoScreensState extends State<AdditionalInfoScreens> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  var _pages = [
    JobSeekingStatus(),
    SelectTopSkill(),
  ];

  initState() {
    Future.delayed(Duration.zero).then((value) {
      widget.additionalInfoViewModel.getData();
    });
    super.initState();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  _navigateToNextPage() {
    _pageController.animateToPage(
      _currentPage + 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  _navigateToPrevPage() {
    _pageController.animateToPage(
      _currentPage - 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  _navigateToOnboardingPage() {
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => OnboardingPage()),
        (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    bool isLastPage = _currentPage == _pages.length - 1;
    bool isFirstPage = _currentPage == 0;
    var continueButton = Container(
      height: 40,
      width: 120,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(10)),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: _navigateToOnboardingPage,
          child: Center(
            child: Text(
              StringResources.continueText,
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
        ),
      ),
    );

    Widget skipButton = AnimatedCrossFade(
      firstCurve: Curves.easeInQuint,
      duration: Duration(milliseconds: 300),
      firstChild: SizedBox(
        width: 120,
      ),
      secondChild: Container(
        height: 40,
        width: 120,
        child: InkWell(
            onTap: _navigateToOnboardingPage,
            borderRadius: BorderRadius.circular(10),
            child: Center(
              child: Text(
                StringResources.skipText,
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            )),
      ),
      crossFadeState:
          isLastPage ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
    var prevButton = isFirstPage
        ? SizedBox(
            width: 46,
          )
        : SizedBox(
            width: 46,
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 30),
              curve: Curves.easeInQuint,
              duration: Duration(milliseconds: 300),
              builder: (context, width, _) {
                return InkWell(
                    onTap: _navigateToPrevPage,
                    borderRadius: BorderRadius.circular(25),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.blue,
                        size: width,
                      ),
                    ));
              },
            ),
          );
    var nextButton = SizedBox(
      width: 46,
      child: InkWell(
        onTap: isLastPage ? _navigateToOnboardingPage : _navigateToNextPage,
        borderRadius: BorderRadius.circular(25),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            switchInCurve: Curves.easeInQuint,
            switchOutCurve: Curves.easeInQuint,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation);
            },
            child: Icon(
              isLastPage ? Icons.check : Icons.keyboard_arrow_right,
              color: Colors.blue,
              key: ValueKey<bool>(isLastPage),
              size: 30,
            ),
          ),
        ),
      ),
    );

    return ChangeNotifierProvider(
      create: (BuildContext context) => widget.additionalInfoViewModel,
      child: Consumer<AdditionalInfoViewModel>(builder: (context, vm, _) {
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
              Container(
                height: 15,
                margin: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length,
                        (index) => SlideDots(index == _currentPage))),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  prevButton,
                  skipButton,
                  nextButton,
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}

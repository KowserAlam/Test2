import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';



Future dashboardInfoBoxTest() async{
  return group('Dashboard Infobox', () {
    final signinEmailField = find.byValueKey('signInEmail');
    final signinPasswordField = find.byValueKey('signInPassword');
    final signinButtonClick = find.byValueKey('signInButton');
    final backButton = find.byTooltip('Back');
    final skipOnboardingScreen = find.text('Skip');
    final infoboxFavoriteButton = find.byValueKey('dashboardFavoriteInfoBox');
    final infoboxAppliedButton = find.byValueKey('dashboardFavoriteInfoBox');
    final clickOnDashboard = find.text('Dashboard');
    final dashBoardContactUsTile = find.byValueKey('dashBoardContactUsTile');
    final dashBoardListview = find.byValueKey('dashBoardListview');

    FlutterDriver driver;
    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    //skillAddField
    //dashboardSkillInfoBox
    //dashboardFavoriteInfoBox
    //dashboardAppliedInfoBox
    //addKey: Key('myProfileAddSkillAdd'),
    //penKey: Key('myProfileAddSkillPen'),
    //test cases are started from here

//    test('Try to login with registered email and password', () async {
//      await driver.tap(signinEmailField);
//      await driver.enterText('mahmudoni01@gmail.com');
//      await driver.tap(signinPasswordField);
//      await driver.enterText('1234567r');
//      await driver.tap(signinButtonClick);
//      await Future.delayed(const Duration(seconds: 3), () {});
//    });

//    test('Skip the onboarding screen after login', () async {
//      await driver.tap(skipOnboardingScreen);
//      await Future.delayed(const Duration(seconds: 6), () {});
//    });

    test('Click on favorite button on infobox', () async {
      await driver.tap(infoboxFavoriteButton);
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(clickOnDashboard);
      await Future.delayed(const Duration(seconds: 4), () {});
    });

    test('Click on contact us tile', () async {
      await driver.scrollUntilVisible(dashBoardListview, dashBoardContactUsTile,
          dyScroll: -600);
      await driver.tap(dashBoardContactUsTile);
      await Future.delayed(const Duration(seconds: 10), () {});
    });
    return;
  });
}

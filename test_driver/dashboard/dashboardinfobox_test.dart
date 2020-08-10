import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';



Future dashboardInfoBoxTest() async{
  return group('Dashboard Infobox', () {
    final backButton = find.byTooltip('Back');
    final infoboxFavoriteButton = find.byValueKey('dashboardFavoriteInfoBox');
    final infoboxAppliedButton = find.byValueKey('dashboardFavoriteInfoBox');
    final clickOnDashboard = find.text('Dashboard');
    final dashBoardContactUsTile = find.byValueKey('dashBoardContactUsTile');
    final dashBoardFAQTile = find.byValueKey('dashBoardFAQTile');
    final dashBoardAboutUsTile = find.byValueKey('dashBoardAboutUsTile');
    final dashBoardListview = find.byValueKey('dashBoardListview');
    final dashboardNotificationIcon = find.byValueKey('dashboardNotificationIcon');


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

    test('Click on Applied button on infobox', () async {
      await driver.tap(infoboxAppliedButton);
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(clickOnDashboard);
      await Future.delayed(const Duration(seconds: 4), () {});
    });

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
      await driver.tap(backButton);
      await Future.delayed(const Duration(seconds: 4), () {});
    });
    test('Click on FAQ tile', () async {
      await driver.scrollUntilVisible(dashBoardListview, dashBoardFAQTile,
          dyScroll: -600);
      await driver.tap(dashBoardFAQTile);
      await Future.delayed(const Duration(seconds: 10), () {});
      await driver.tap(backButton);
      await Future.delayed(const Duration(seconds: 4), () {});
    });
    test('Click on About Us tile', () async {
      await driver.scrollUntilVisible(dashBoardListview, dashBoardAboutUsTile,
          dyScroll: -600);
      await driver.tap(dashBoardAboutUsTile);
      await Future.delayed(const Duration(seconds: 10), () {});
      await driver.tap(backButton);
      await Future.delayed(const Duration(seconds: 4), () {});
    });

    test('Click on Notification icon to check notifications', () async {
      await driver.tap(dashboardNotificationIcon);
      await Future.delayed(const Duration(seconds: 6), () {});
      await driver.tap(backButton);
      await Future.delayed(const Duration(seconds: 4), () {});
    });
    return;
  });
}

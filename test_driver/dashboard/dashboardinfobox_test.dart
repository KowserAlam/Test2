import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';



Future dashboardInfoBoxTest() async{
  return group('Dashboard Infobox', () {
    final backButton = find.byTooltip('Back');
    final infoboxFavoriteButton = find.byValueKey('dashboardFavoriteInfoBox');
    final infoboxAppliedButton = find.byValueKey('dashboardAppliedInfoBox');
    final clickOnDashboard = find.text('Dashboard');
    final dashBoardContactUsTile = find.byValueKey('dashBoardContactUsTile');
    final dashBoardFAQTile = find.byValueKey('dashBoardFAQTile');
    final dashBoardAboutUsTile = find.byValueKey('dashBoardAboutUsTile');
    final dashBoardListview = find.byValueKey('dashBoardListview');
    final dashboardNotificationIcon = find.byValueKey('dashboardNotificationIcon');
    final careerAdviceViewAll = find.byValueKey('careerAdviceViewAll');
    final careerAdviceTile1 = find.byValueKey('careerAdviceTile1');
    final careerAdviceTile2 = find.byValueKey('careerAdviceTile2');
    final careerAdviceTile3 = find.byValueKey('careerAdviceTile3');
    final careerAdviceTile4 = find.byValueKey('careerAdviceTile4');
    final careerAdviceTile5 = find.byValueKey('careerAdviceTile5');

    //wait for text
    //final waitForNotification = find.text('Notification');


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
      await driver.tap(backButton);
    });
    test('Click on FAQ tile', () async {
      await driver.scrollUntilVisible(dashBoardListview, dashBoardFAQTile,
          dyScroll: -600);
      await driver.tap(dashBoardFAQTile);
      //await Future.delayed(const Duration(seconds: 9), () {});
      await driver.tap(backButton);
    });
    test('Click on About Us tile', () async {
      await driver.scrollUntilVisible(dashBoardListview, dashBoardAboutUsTile,
          dyScroll: -600);
      await driver.tap(dashBoardAboutUsTile);
      //await Future.delayed(const Duration(seconds: 9), () {});
      await driver.tap(backButton);
    });

    test('Click on Notification icon to check notifications', () async {
      await driver.tap(dashboardNotificationIcon);
      await Future.delayed(const Duration(seconds: 2), () {});
      await driver.tap(backButton);
    });

    test('Click on Career Advice - View All', () async {
      await driver.tap(careerAdviceViewAll);
      await Future.delayed(const Duration(seconds: 2), () {});
      await driver.tap(backButton);
    });

    test('Click on Career Advice - 1st tile', () async {
      await driver.tap(careerAdviceTile1);
      //await Future.delayed(const Duration(seconds: 6), () {});
      await driver.tap(backButton);
    });

    test('Click on Career Advice - 2nd tile', () async {
      await driver.tap(careerAdviceTile2);
      //await Future.delayed(const Duration(seconds: 6), () {});
      await driver.tap(backButton);
    });

    test('Click on Career Advice - 3rd tile', () async {
      await driver.tap(careerAdviceTile3);
      //await Future.delayed(const Duration(seconds: 6), () {});
      await driver.tap(backButton);
    });

    test('Click on Career Advice - 4th tile', () async {
      await driver.tap(careerAdviceTile4);
      //await Future.delayed(const Duration(seconds: 6), () {});
      await driver.tap(backButton);
    });

    test('Click on Career Advice - 5th tile', () async {
      await driver.tap(careerAdviceTile5);
      //await Future.delayed(const Duration(seconds: 6), () {});
      await driver.tap(backButton);
    });
    return;
  });
}

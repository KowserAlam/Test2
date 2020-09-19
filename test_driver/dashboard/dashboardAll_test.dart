import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import '../keys.dart';



main(){
  dashboardAll();
}

Future<void> dashboardAll() async{
  return group('Dashboard All', () {
    final backButton = find.byTooltip('Back');
    final infoboxFavoriteButton = find.byValueKey('dashboardFavoriteInfoBox');
    final dashboardAppliedInfoBox = find.byValueKey('dashboardAppliedInfoBox');
    final dashBoardContactUsTile = find.byValueKey('dashBoardContactUsTile');
    final contactUsTextOnAppBar = find.byValueKey('contactUsTextOnAppBar');
    final dashBoardFAQTile = find.byValueKey('dashBoardFAQTile');
    final faqAppBarTitleKey = find.byValueKey('faqAppBarTitleKey');
    final dashBoardAboutUsTile = find.byValueKey('dashBoardAboutUsTile');
    final aboutUsAppBarTitleKey = find.byValueKey('aboutUsAppBarTitleKey');
    final dashBoardListview = find.byValueKey('dashBoardListview');
    final dashboardHorizontalCareerAdviceListKey = find.byValueKey('dashboardHorizontalCareerAdviceListKey');
    final dashboardNotificationIcon = find.byValueKey('dashboardNotificationIcon');
    final careerAdviceViewAll = find.byValueKey('careerAdviceViewAll');
    final careerAdviceTile1 = find.byValueKey('careerAdviceTile1');
    final careerAdviceTile2 = find.byValueKey('careerAdviceTile2');
    final careerAdviceTile3 = find.byValueKey('careerAdviceTile3');
    final careerAdviceTile4 = find.byValueKey('careerAdviceTile4');
    final careerAdviceTile5 = find.byValueKey('careerAdviceTile5');
    final FAQ = find.text('Frequently Asked Questions');
    final dashboardMonthlyJobsTextKey = find.byValueKey('dashboardMonthlyJobsTextKey');


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

    test('If no skilles added, showing skill add button', () async {
      if(Keys.dashboardAddSkillButton != null){
        await expect(driver.waitFor(Keys.dashboardAddSkillButton), 'Add Skill');
      }else{
        await expect(driver.waitFor(dashboardMonthlyJobsTextKey), 'Monthly Jobs');
      }
    });

    test('Click on Applied button on infobox', () async {
      await driver.tap(dashboardAppliedInfoBox);
      await Future.delayed(const Duration(seconds: 15), () {});
      await driver.tap(Keys.bottomNavigationBarDashboard);
      await Future.delayed(const Duration(seconds: 4), () {});
    });

    test('Click on favorite button on infobox', () async {
      await driver.tap(infoboxFavoriteButton);
      await Future.delayed(const Duration(seconds: 15), () {});
      await driver.tap(Keys.bottomNavigationBarDashboard);
      await Future.delayed(const Duration(seconds: 4), () {});
    });

    test('Click on contact us tile', () async {
      await driver.scrollUntilVisible(dashBoardListview, dashBoardContactUsTile,
          dyScroll: -600);
      await driver.tap(dashBoardContactUsTile);
      await expect(await driver.getText(contactUsTextOnAppBar), 'Contact Us');
      await Future.delayed(const Duration(seconds: 5), () {});
      //contactUsTextOnAppBar
    });
    test('Click on FAQ tile', () async {
      await driver.tap(dashBoardFAQTile);
      await expect(await driver.getText(faqAppBarTitleKey), 'FAQ');
      await expect(await driver.getText(FAQ), 'Frequently Asked Questions');
      await Future.delayed(const Duration(seconds: 15), () {});
      await driver.tap(backButton);
    });
    test('Click on About Us tile', () async {
      await driver.tap(dashBoardAboutUsTile);
      await expect(await driver.getText(aboutUsAppBarTitleKey), 'About Us');
      await Future.delayed(const Duration(seconds: 6), () {});
      await driver.tap(backButton);
    });

    //it has been commented because notification section is hidden for now
    /*test('Click on Notification icon to check notifications', () async {
      await driver.tap(dashboardNotificationIcon);
      await expect(await driver.getText(Keys.notificationsTextOnAppBar), 'Notifications');
      await Future.delayed(const Duration(seconds: 2), () {});
      await driver.tap(backButton);
    });
*/
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
      await driver.scrollUntilVisible(dashboardHorizontalCareerAdviceListKey, careerAdviceTile3,
          dyScroll: -600);
      await driver.tap(careerAdviceTile3);
      //await Future.delayed(const Duration(seconds: 6), () {});
      await driver.tap(backButton);
    });

    test('Click on Career Advice - 4th tile', () async {
      await driver.scrollUntilVisible(dashboardHorizontalCareerAdviceListKey, careerAdviceTile4,
          dyScroll: -600);
      await driver.tap(careerAdviceTile4);
      //await Future.delayed(const Duration(seconds: 6), () {});
      await driver.tap(backButton);
    });

    test('Click on Career Advice - 5th tile', () async {
      await driver.scrollUntilVisible(dashboardHorizontalCareerAdviceListKey, careerAdviceTile5,
          dyScroll: -600);
      await driver.tap(careerAdviceTile5);
      //await Future.delayed(const Duration(seconds: 6), () {});
      await driver.tap(backButton);
    });

    //appliedJobsTest();
  });

}

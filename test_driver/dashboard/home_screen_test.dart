import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import '../keys.dart';



main(){
  homeScreenTest();
}

Future<void> homeScreenTest() async{
  return group('Home Test', () {
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
    final onTapSearch = find.byValueKey('onTapSearch');


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

    test('check home header search nevigates to job list', () async {
      await Future.delayed(const Duration(seconds: 12), () {});
      print('1');
      await driver.tap(Keys.homeOnTapSearchPushToAllJobsKey);
      print('2');
      await driver.tap(Keys.jobListSearchInputFieldKey);
      await expect(driver.getText(Keys.jobsAppbarTitle), 'Jobs');
      await driver.tap(Keys.bottomNavigationBarDashboard);
    });

    test('Check please login sends to login screen', () async {
      await driver.tap(Keys.dashboardLoginPleaseSigningKey);
      await Future.delayed(const Duration(seconds: 3), () {});
      await expect(await driver.getText(Keys.signInWelcomeText), 'Welcome back!');
      await driver.tap(Keys.backButton);
    });

    test('Check featured companies view all', () async {
      await driver.tap(Keys.featuredCompanyViewAll);
      await Future.delayed(const Duration(seconds: 8), () {});
      await expect(await driver.getText(find.text('Please sign in to proceed !')), 'Please sign in to proceed !');
      await driver.tap(Keys.bottomNavigationBarDashboard);
    });

    test('Check featured companies 1st tile', () async {
      await driver.tap(Keys.featuredCompaniesTileKey1);
      await Future.delayed(const Duration(seconds: 5), () {});
      await expect(await driver.getText(Keys.companyDetailsAppbarTitle), 'Company Details');
      await driver.tap(Keys.backButton);
    });

    test('Check featured companies 2nd tile', () async {
      await driver.tap(Keys.featuredCompaniesTileKey2);
      await Future.delayed(const Duration(seconds: 5), () {});
      await expect(await driver.getText(Keys.companyDetailsAppbarTitle), 'Company Details');
      await driver.tap(Keys.backButton);
    });

    test('Click on contact us tile', () async {
      await driver.scrollUntilVisible(Keys.dashboardListview, dashBoardContactUsTile,
          dyScroll: -200);
      await driver.tap(dashBoardContactUsTile);
      await expect(await driver.getText(contactUsTextOnAppBar), 'Contact Us');
      await Future.delayed(const Duration(seconds: 5), () {});
      await driver.tap(Keys.backButton);
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

  });

}

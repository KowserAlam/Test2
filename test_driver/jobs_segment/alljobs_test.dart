import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import '../keys.dart';
import '../other_pages/contactus_test.dart';

main(){
  allJobsTest();
}
Future<void> allJobsTest()async{

  group('All Jobs Test: ', () {
    final jobListSearchToggleButtonKey = find.byValueKey('jobListSearchToggleButtonKey');
    final jobListSearchInputFieldKey = find.byValueKey('jobListSearchInputFieldKey');
    final jobListSearchButtonKey = find.byValueKey('jobListSearchButtonKey');

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
    test('Go to All Jobs on jobs Screen segment control bar', () async {
      await driver.tap(Keys.clickOnAllJobsFromSegmentScreen);
      await Future.delayed(const Duration(seconds: 5), () {});
    });
    test('Check if job details are showing from All jobs list', () async {
      await driver.tap(Keys.clickOnFirstTileOnAllJobs); //to see job details is working
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(Keys.backButton);
    });

    test('Check Favorite button is working', () async {
      await driver.tap(Keys.checkFavoriteUnfavoriteFromAllJobsList);
      await Future.delayed(const Duration(seconds: 4), () {});
    });

    test('Check Unfavorite button is working', () async {
      await driver.tap(Keys.checkFavoriteUnfavoriteFromAllJobsList);
      await Future.delayed(const Duration(seconds: 4), () {});

    });
    test('Check toggle Search button is working', () async {
      await driver.tap(jobListSearchToggleButtonKey);
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(jobListSearchToggleButtonKey);
    });

    test('Check Random input search is working', () async {
      await driver.tap(jobListSearchToggleButtonKey);
      await driver.enterText('randomText');
      await driver.tap(jobListSearchButtonKey);
      await Future.delayed(const Duration(seconds: 5), () {});
    });

    test('Check DevOps input search is working', () async {
      await driver.tap(jobListSearchToggleButtonKey);
      await driver.enterText('DevOps');
      await driver.tap(jobListSearchButtonKey);
      await Future.delayed(const Duration(seconds: 5), () {});
    });

    test('Check Software input search is working', () async {
      await driver.tap(jobListSearchToggleButtonKey);
      await driver.enterText('Software');
      await driver.tap(jobListSearchButtonKey);
      await Future.delayed(const Duration(seconds: 5), () {});
    });


    contactUSTest();

  });

}

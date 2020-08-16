import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import '../keys.dart';

main(){
  appliedJobsTest();
}
Future<void> appliedJobsTest()async{

  group('Applied Jobs Test', () {

    //final clickOnAppliedJobsFromSegmentScreen = find.bySemanticsLabel(StringResources.favoriteText);
    //final clickOnAppliedJobsFromSegmentScreen = find.bySemanticsLabel(StringResources.allText);

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

    //auth
    test('Try to login with registered email and password', () async {
      await driver.tap(keys.signInEmail);
      await driver.enterText('mahmudoni01@gmail.com');
      await driver.tap(keys.signInPassword);
      await driver.enterText('1234567r');
      await driver.tap(keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), () {});
    });

    test('Click on Jobs from bottom navigation bar', () async {
      await driver.tap(keys.bottomNavigationBarJobs);
      await Future.delayed(const Duration(seconds: 10), () {});
    });

    test('Click on Applied Jobs on jobs Screen segment control bar', () async {
      await driver.tap(keys.clickOnAppliedJobsFromSegmentScreen);
      await Future.delayed(const Duration(seconds: 5), () {});
    });

    test('Check if job details are showing from applied job list', () async {
      await driver.tap(keys.clickOnFirstTileOnAppliedJobs); //to see job details is working from applied job list
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(keys.backButton);
    });

    test('Check ', () async {
      await driver.tap(keys.clickOnFirstTileOnAppliedJobs); //to see job details is working from applied job list
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(keys.backButton);
    });



  });
//flutter drive --flavor dev --target=test_driver/bottom_nav_bar/appliedjobs.dart
}

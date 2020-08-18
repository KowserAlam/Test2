import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';
import 'favoritejobs_test.dart';

main(){
  appliedJobsTest();
}
Future<void> appliedJobsTest()async{

  group('Applied Jobs Test :', () {

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

    //remove comment when it needs to be run individually
      /*test('login with registered email and password', () async {
      await driver.tap(Keys.signInEmail);
      await driver.enterText('mahmudoni01@gmail.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), () {});
    });*/

    test('Click on Jobs from bottom navigation bar', () async {
      await driver.tap(Keys.bottomNavigationBarJobs);
      await Future.delayed(const Duration(seconds: 10), () {});
    });

    test('Click on Applied Jobs on jobs Screen segment control bar', () async {
      await driver.tap(Keys.clickOnAppliedJobsFromSegmentScreen);
      await Future.delayed(const Duration(seconds: 5), () {});

     // expect((tester.firstWidget(find.byType(MaterialApp)) as Material).color, Colors.blue[200]);
    });

    //showing job details
    test('Check if job details are showing from applied job list', () async {
      await driver.tap(Keys.clickOnFirstTileOnAppliedJobs); //to see job details is working from applied job list
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(Keys.backButton);
    });

    test('Check Favorite button is working', () async {
      await driver.tap(Keys.checkFavoriteUnfavoriteFromAppliedList);
      await Future.delayed(const Duration(seconds: 4), () {});
    });

    test('Check Unfavorite button is working', () async {
      await driver.tap(Keys.checkFavoriteUnfavoriteFromAppliedList);
      await Future.delayed(const Duration(seconds: 4), () {});

    });

  });
  favoriteJobsTest();
}
//flutter drive --flavor dev --target=test_driver/jobs_segment/appliedjobs.dart

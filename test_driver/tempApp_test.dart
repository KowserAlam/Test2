import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'dashboard/dashboardinfobox_test.dart';
import 'jobs_segment/appliedjobs_test.dart';
import 'jobs_segment/favoritejobs_test.dart';
import 'keys.dart';


main() {
  allJobsTest();
}

Future<void> allJobsTest() async {
  group('All Jobs Test: ', () {
    final jobListSearchToggleButtonKey =
    find.byValueKey('jobListSearchToggleButtonKey');
    final jobListSearchInputFieldKey =
    find.byValueKey('jobListSearchInputFieldKey');
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

    test('login with registered email and password', () async {
      await driver.tap(Keys.signInEmail);
      await driver.enterText('mahmudoni01@gmail.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), () {});
    });

    dashboardInfoBoxTest();

    favoriteJobsTest();

    appliedJobsTest();
  });
}

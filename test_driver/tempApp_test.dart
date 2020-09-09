import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'auth/forgotpassword_test.dart';
import 'auth/login_test.dart';
import 'auth/signup_test.dart';
import 'company/company_test.dart';
import 'dashboard/dashboardinfobox_test.dart';
import 'jobs_segment/alljobs_test.dart';
import 'jobs_segment/appliedjobs_test.dart';
import 'jobs_segment/favoritejobs_test.dart';
import 'jobs_segment/filter_test.dart';
import 'keys.dart';
import 'other_pages/contactus_test.dart';
import 'settings/other_settings_test.dart';


main() {
  allTestCaseAtOnce();
}

Future<void> allTestCaseAtOnce() async {
  group('All TestCase at Once: ', () {
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
    forgotPasswordTest();

    signUpTest();

    loginTest();

    test('login with registered email and password', () async {
      await driver.tap(Keys.signInEmail);
      await driver.enterText('mahmudoni01@gmail.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), () {});
    });

    dashboardInfoBoxTest();

    appliedJobsTest();

    favoriteJobsTest();

    allJobsTest();

    contactUSTest();

    company();

    filterTest();

    otherSettings();

  });
}

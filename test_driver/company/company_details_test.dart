import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';

//flutter drive --flavor dev --target=test_driver/jobs_segment/job_details.dart


main() {
  jobDetailsTest();
}

Future<void> jobDetailsTest() async {
  String jobTitle ,jobCompanyName;

  group('Company Details Test Cases: ', () {

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
    test('Getting to All Jobs screen', () async {
      await driver.tap(Keys.signInEmail);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567s');
      await driver.tap(Keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await driver.tap(Keys.bottomNavigationBarJobs);
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Getting to Job Detail screen', () async {
      await driver.tap(Keys.jobListSearchToggleButtonKey);
      await driver.tap(Keys.jobListSearchInputFieldKey);
      await driver.enterText('Test Job Title 789');
      await driver.tap(Keys.jobListSearchButtonKey);
      jobTitle = await driver.getText(Keys.jobTileJobTitle);
      jobCompanyName = await driver.getText(Keys.jobTileCompanyName);
      await driver.tap(Keys.allJobsTile0);
      await expect(await driver.getText(Keys.jobDetailsAppbarTitle), 'Job Details');
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Check if clicking a job tile goes to that tile\'s job details', () async {
      await expect(await driver.getText(Keys.jobDetailsJobTitle), jobTitle);
      await expect(await driver.getText(Keys.jobDetailsCompanyName), jobCompanyName);
      await Future.delayed(const Duration(seconds: 5), (){});
    });


  });
}

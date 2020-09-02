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

    test('Check showing deadline if not found show none', () async {
      await expect(await driver.getText(Keys.jobDetailsDeadlineDate), '');
      await expect(await driver.getText(Keys.jobDetailsCompanyName), jobCompanyName);
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check if clicking on company name gets user to company details of that company', () async {
      await driver.tap(Keys.jobDetailsCompanyName);
      await expect(await driver.getText(Keys.companyDetailsCompanyName), jobCompanyName);
      await driver.tap(Keys.backButton);
      await expect(await driver.getText(Keys.jobDetailsAppbarTitle), 'Job Details');
    });

    test('Check favorite button can favorite the job', () async {
      await driver.tap(Keys.jobDetailsFavoriteButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      //await expect(await driver.getText(Keys.checkJobFavorite), 'favorite');
      await driver.tap(Keys.jobDetailsFavoriteButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      //await expect(await driver.getText(Keys.checkJobFavorite), 'notFavorite');
    });

//    test('Check apply button is working', () async {
//      //await expect(await driver.getText(Keys.applyButtonText), 'Apply');
//      await driver.tap(Keys.jobDetailsApplyButton);
//      await driver.tap(Keys.jobDetailsApplyYesButton);
//      //await expect(await driver.getText(Keys.applyButtonText), 'Applied');
//      await driver.tap(Keys.backButton);
//      await expect(await driver.getText(Keys.jobsAppbarTitle), 'Jobs');
//      print('4');
//      await driver.tap(Keys.jobsSegmentAppliedText);
//      await driver.tap(Keys.appliedTileKey);
//      await expect(await driver.getText(Keys.jobDetailsJobTitle), jobTitle);
//    });

    test('Check scroll / pagination working', () async {
      await driver.scrollUntilVisible(Keys.jobDetailsScrollKey, Keys.similarJobsTitle, dyScroll: -1000);
      await expect(await driver.getText(Keys.similarJobsTitle), 'Similar Jobs');
    });

    test('Check similer jobs are showing if have', () async {
      await driver.scrollUntilVisible(Keys.jobDetailsScrollKey, Keys.similarJobsTile, dyScroll: -20);
      await driver.tap(Keys.similarJobsTile);
      await expect(await driver.getText(Keys.jobDetailsJobTitle), 'Test Job Title 789');
      await driver.tap(Keys.backButton);
    });

    test('Check favorite button can favorite the similar job', () async {
      await driver.tap(Keys.similarJobsTileFavorite);
      await Future.delayed(const Duration(seconds: 3), (){});
      //await expect(await driver.getText(Keys.checkJobFavorite), 'favorite');
      await driver.tap(Keys.similarJobsTileFavorite);
      await Future.delayed(const Duration(seconds: 3), (){});
      //await expect(await driver.getText(Keys.checkJobFavorite), 'notFavorite');
    });

    test('Check if publish date & deadline date is showing', () async {
      await expect(await driver.getText(Keys.similarJobsTilePublishedDate), '');
      await expect(await driver.getText(Keys.similarJobsTileDeadline0), jobCompanyName);
      await Future.delayed(const Duration(seconds: 5), (){});
    });



  });
}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';

//flutter drive --flavor dev --target=test_driver/jobs_segment/job_details.dart


main() {
  jobDetailsTest();
}

Future<void> jobDetailsTest() async {
  String jobTitle ,jobCompanyName;

  group('Job Details & Similar Jobs Tests: ', () {

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

//    test('Check showing deadline if not found show none', () async {
//      await expect(await driver.getText(Keys.jobDetailsDeadlineDate), 'none');
//      await driver.tap(Keys.backButton);
//      await driver.tap(Keys.allJobsTile1);
//      await expect(await driver.getText(Keys.jobDetailsDeadlineDate), '01/09/2020');
//      await driver.tap(Keys.backButton);
//      await driver.tap(Keys.allJobsTile0);
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });

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

    test('Check Apply button showing popup', () async {
      //await expect(await driver.getText(Keys.applyButtonText), 'Apply');
      await driver.tap(Keys.jobDetailsApplyButton);
      await expect(await driver.getText(Keys.jobDetailsApplyButtonText), 'Do you want to apply for this job?');
    });

    test('Check popup Yes button is working', () async {
      await driver.tap(Keys.jobDetailsApplyYesButton);
      await driver.tap(Keys.backButton);
      await expect(await driver.getText(Keys.jobsAppbarTitle), 'Jobs');
      await driver.tap(Keys.jobsSegmentAppliedText);
      await driver.tap(Keys.appliedTileKey0);
      await expect(await driver.getText(Keys.jobDetailsJobTitle), jobTitle);
    });

    test('Check scroll / pagination working', () async {
      await driver.scrollUntilVisible(Keys.jobDetailsScrollKey, Keys.similarJobsTitle, dyScroll: -1000);
      await expect(await driver.getText(Keys.similarJobsTitle), 'Similar Jobs');
    });

    test('Check similer jobs are showing if have', () async {
      await driver.scrollUntilVisible(Keys.jobDetailsScrollKey, Keys.similarJobsTile, dyScroll: -20);
      await driver.tap(Keys.similarJobsTile);
      await expect(await driver.getText(Keys.jobDetailsJobTitle), 'Test Job Title 78');
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

    test('Check if publish deadline date is showing', () async {
      await expect(await driver.getText(Keys.similarJobsTileDeadline0), 'none');
      await expect(await driver.getText(Keys.similarJobsTileDeadline1), '01/09/2022');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check if company name is showing', () async {
      await expect(await driver.getText(Keys.jobTileCompanyName), 'Ishraak Solutions');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check if company location is showing', () async {
      await expect(await driver.getText(Keys.similarJobsTileCompanyLocation), 'Khulna, Bangladesh');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check Similar jobs Apply button showing popup', () async {
      await driver.tap(Keys.similarJobsTileApply);
      await expect(await driver.getText(Keys.commonPromptText), 'Do you want to apply for this job?');
    });

    test('Check popup Yes button is working', () async {
      await driver.tap(Keys.commonPromptYes);
      await driver.tap(Keys.backButton);
      await expect(await driver.getText(Keys.jobsAppbarTitle), 'Jobs');
      await driver.tap(Keys.jobsSegmentAppliedText);
      await driver.tap(Keys.appliedTileKey1);
      await expect(await driver.getText(Keys.jobDetailsJobTitle), jobTitle);
    });




  });
}

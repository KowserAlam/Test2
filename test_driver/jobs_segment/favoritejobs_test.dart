import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';

//flutter drive --flavor dev --target=test_driver/jobs_segment/favoritejob.dart


main() {
  favoriteJobsTest();
}

Future<void> favoriteJobsTest() async {
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
    test('Getting to Favorite Jobs screen', () async {
      await driver.tap(Keys.jobsSegmentFavoriteText);
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check favorited job list are showing if dont have favorited jobs showing null massage', () async {
      await expect(await driver.getText(Keys.noFavoriteJobs), 'You don\'t have any favorite job');
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Check clicking favorite on a job gets it to favorite screen', () async {
      await driver.tap(Keys.jobsSegmentAllText);
      await driver.tap(Keys.jobListSearchToggleButtonKey);
      await driver.tap(Keys.jobListSearchInputFieldKey);
      await driver.enterText('Test Job Title 789');
      await driver.tap(Keys.jobListSearchButtonKey);
      await driver.tap(Keys.allJobsTileFavoriteButton);
      await driver.tap(Keys.allJobsTileFavoriteButton1);
      await Future.delayed(const Duration(seconds: 2), (){});
      await driver.tap(Keys.jobsSegmentFavoriteText);
      await expect(await driver.getText(Keys.jobTileJobTitle0), 'Test Job Title 789');
      await expect(await driver.getText(Keys.jobTileJobTitle1), 'Test Job Title 7890');
    });

    test('Check showing deadline if not found show none', () async {
      await expect(await driver.getText(Keys.favoriteDeadline0), '02/09/2022');
      await expect(await driver.getText(Keys.favoriteDeadline1), 'none');
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Check if company name is showing', () async {
      await expect(await driver.getText(Keys.jobTileCompanyName), 'Ishraak Solutions');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check if company location is showing', () async {
      await expect(await driver.getText(Keys.favoriteCompanyLocation), 'Khulna, Bangladesh');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

//    test('Check favorite button can favorite & unfavorite the similar job', () async {
//      await driver.tap(Keys.similarJobsTileFavorite);
//      await Future.delayed(const Duration(seconds: 3), (){});
//      //await expect(await driver.getText(Keys.checkJobFavorite), 'favorite');
//      await driver.tap(Keys.similarJobsTileFavorite);
//      await Future.delayed(const Duration(seconds: 3), (){});
//      //await expect(await driver.getText(Keys.checkJobFavorite), 'notFavorite');
//    });
//
//    test('Check if publish deadline date is showing', () async {
//      await expect(await driver.getText(Keys.similarJobsTileDeadline0), 'none');
//      await expect(await driver.getText(Keys.similarJobsTileDeadline1), '01/09/2022');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
//
//
//


    test('Check Similar jobs Apply button showing popup', () async {
      await driver.tap(Keys.favoriteJobsApplyButton);
      await expect(await driver.getText(Keys.commonPromptText), 'Do you want to apply for this job?');
    });

    test('Check popup Yes button is working', () async {
      await driver.tap(Keys.commonPromptYes);
      await driver.tap(Keys.jobsSegmentAppliedText);
      await expect(await driver.getText(Keys.jobTileJobTitle0), 'Test Job Title 789');
    });


  });
}

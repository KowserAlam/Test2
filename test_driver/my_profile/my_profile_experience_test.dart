import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


//flutter drive --flavor dev --target=test_driver/my_profile/my_profile_experience.dart

void main() {
  group('My Profile - Experience Test', () {


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
    test('Getting to My Profile screen', () async {
      await driver.tap(Keys.signInEmail);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567s');
      await driver.tap(Keys.signInButton);
//      await Future.delayed(const Duration(seconds: 3), (){});
//      await driver.tap(keys.onboardingPageSkipButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await driver.tap(Keys.bottomNavigationBarMyProfile);
      await Future.delayed(const Duration(seconds: 5), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
    });

    test('Get to edit experience screen', () async {
      await driver.scrollUntilVisible(Keys.myProfileScrollView, Keys.myProfileExperiencePenKey, dyScroll: -20);
      await driver.tap(Keys.myProfileExperiencePenKey);
      await driver.tap(Keys.myProfileExperienceAddKey);
      await expect(await driver.getText(Keys.workExperienceAppbarTitleKey), 'Work Experience');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Try to save while all fields are empty', () async {
      await driver.tap(Keys.workExperienceSaveButton);
      await expect(await driver.getText(Keys.workExperienceAppbarTitleKey), 'Work Experience');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Try to save while only company is filled from our list of companies', () async {
      await driver.tap(Keys.experienceCompanyName);
      await driver.enterText('Ishraak Solutions');
      await driver.tap(Keys.workExperienceSaveButton);
      await expect(await driver.getText(Keys.workExperienceAppbarTitleKey), 'Work Experience');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Try with only joining date it can be saved or not', () async {
      await driver.tap(Keys.experienceJoiningDate);
      await Future.delayed(const Duration(seconds: 3), (){});
      await driver.tap(Keys.doneButtonKey);
      await driver.tap(Keys.workExperienceSaveButton);
      await expect(await driver.getText(Keys.workExperienceAppbarTitleKey), 'Work Experience');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Try to save after checkbox is clicked', () async {
      await driver.tap(Keys.experienceCurrentlyWorkingKey);
      await driver.tap(Keys.workExperienceSaveButton);
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check if edit is working.', () async {
      await driver.tap(Keys.experienceEditButton);
      await driver.tap(Keys.experienceCompanyName);
      await driver.enterText('Test Company');
      await driver.tap(Keys.workExperienceSaveButton);
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.experienceTileCompanyName), 'Test Company');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check again if edit is working.', () async {
      await driver.tap(Keys.experienceEditButton);
      await driver.tap(Keys.experienceCompanyName);
      await driver.enterText('Test Company Updated');
      await driver.tap(Keys.workExperienceSaveButton);
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.experienceTileCompanyName), 'Test Company Updated');
      await Future.delayed(const Duration(seconds: 5), (){});
    });


//    test('Check if designation can be saved', () async {
//      await driver.tap(Keys.experienceEditButton);
//      await driver.tap(Keys.experienceDesignationKey);
//      await driver.enterText('Test Designation');
////      await driver.tap(Keys.experienceDescriptionKey);
////      await driver.enterText('Test Description');
//      await Future.delayed(const Duration(seconds: 3), (){});
//      await driver.tap(Keys.workExperienceSaveButton);
//      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
//      await expect(await driver.getText(Keys.experienceTileDesignation), 'Test Designation');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });

//    test('Check if description can be saved & showing', () async {
//      await driver.tap(Keys.experienceEditButton);
//      await driver.tap(Keys.experienceDescriptionKey);
//      await driver.enterText('Test Description');
//      await Future.delayed(const Duration(seconds: 3), (){});
//      await driver.tap(Keys.workExperienceSaveButton);
//      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
//
//    test('Try to save after filled leaving date', () async {
//      await driver.tap(Keys.experienceEditButton);
//      await driver.tap(Keys.experienceCurrentlyWorkingKey);
//      await driver.tap(Keys.experienceLeavingDate);
//      await Future.delayed(const Duration(seconds: 3), (){});
//      await driver.tap(Keys.doneButtonKey);
//      await driver.tap(Keys.workExperienceSaveButton);
//      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
//
//    test('Add a new entry to test if delete is working', () async {
//      await driver.tap(Keys.myProfileExperienceAddKey);
//      await driver.tap(Keys.experienceCompanyName);
//      await driver.enterText('Test Company');
//      await driver.tap(Keys.experienceJoiningDate);
//      await Future.delayed(const Duration(seconds: 3), (){});
//      await driver.tap(Keys.doneButtonKey);
//      await driver.tap(Keys.experienceCurrentlyWorkingKey);
//      await driver.tap(Keys.workExperienceSaveButton);
//      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
//      await expect(await driver.getText(Keys.experienceTileCompanyName), 'Test Company');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
//
//    test('Check if delete is working', () async {
//      await expect(await driver.getText(Keys.experienceTileCompanyName), 'Ishraak Solutions');
//      await driver.tap(Keys.experienceDeleteButton);
//      await driver.tap(Keys.myProfileDialogBoxDeleteTile);
//      await expect(await driver.getText(Keys.experienceTileCompanyName), 'Test Company');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });


  });

}

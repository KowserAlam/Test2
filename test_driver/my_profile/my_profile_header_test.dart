import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


//flutter drive --flavor dev --target=test_driver/my_profile/my_profile_header.dart

void main() {
  group('My Profile - Header Test', () {


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
      await Future.delayed(const Duration(seconds: 3), (){});
//      await driver.tap(Keys.onboardingPageSkipButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
      await driver.tap(Keys.bottomNavigationBarMyProfile);
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check if edit profile header button is working', () async {
      await driver.tap(Keys.myProfileHeaderEditButton);
      await expect(await driver.getText(Keys.myProfileHeaderAppbarTitle), 'Edit Profile');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

//    test('Try to save while all fields are empty', () async {
//      await driver.tap(keys.myProfileHeaderSaveButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
//      await expect(await driver.getText(keys.myProfileHeaderAppbarTitle), 'EDIT PROFILE');
//    });
//
//    test('Try to save with only name field is filled', () async {
//      await driver.tap(keys.myProfileHeaderFullNameField);
//      await driver.enterText('Test Full Name');
//      await driver.tap(keys.myProfileHeaderSaveButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
//      await expect(await driver.getText(keys.myProfileHeaderAppbarTitle), 'EDIT PROFILE');
//    });

    test('Try to save with Name & Mobile.', () async {
      await driver.tap(Keys.myProfileHeaderFullNameField);
      await driver.enterText('Test Full Name');
      await driver.tap(Keys.myProfileHeaderMobileField);
      await driver.enterText('01711111111');
      await driver.tap(Keys.myProfileHeaderSaveButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.myProfileHeaderName), 'Test Full Name');
      await expect(await driver.getText(Keys.myProfileHeaderPhone), '01711111111');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check Description can be saved and showing', () async {
      await driver.tap(Keys.myProfileHeaderEditButton);
      await driver.tap(Keys.myProfileHeaderDescriptionField);
      await driver.enterText('Test Description');
      await driver.tap(Keys.myProfileHeaderSaveButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      //await expect(keys.myProfileHeaderDescription, 'Test Description');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check Current Company can be saved and showing', () async {
      await driver.tap(Keys.myProfileHeaderEditButton);
      await driver.tap(Keys.myProfileHeaderCurrentCompanyField);
      await driver.enterText('Test Company');
      await driver.tap(Keys.myProfileHeaderSaveButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.myProfileHeaderCompany), 'Test Company');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check Current Designation can be saved and showing', () async {
      await driver.tap(Keys.myProfileHeaderEditButton);
      await driver.scrollUntilVisible(Keys.myProfileHeaderScrollView, Keys.myProfileHeaderCurrentDesignationField, dyScroll: -40);
      await driver.tap(Keys.myProfileHeaderCurrentDesignationField);
      await driver.enterText('Test Designation');
      await driver.tap(Keys.myProfileHeaderSaveButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.myProfileHeaderDesignation), 'Test Designation');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check Current Location can be saved and showing', () async {
      await driver.tap(Keys.myProfileHeaderEditButton);
      await driver.scrollUntilVisible(Keys.myProfileHeaderScrollView, Keys.myProfileHeaderLocationField, dyScroll: -50);
      await driver.tap(Keys.myProfileHeaderLocationField);
      await driver.enterText('Test Location');
      await driver.tap(Keys.myProfileHeaderSaveButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.myProfileHeaderLocation), 'Test Location');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check Current Years of Experience can be saved and showing', () async {
      await driver.tap(Keys.myProfileHeaderEditButton);
      await driver.scrollUntilVisible(Keys.myProfileHeaderScrollView, Keys.myProfileHeaderExperienceInYearField, dyScroll: -20);
      await driver.tap(Keys.myProfileHeaderExperienceInYearField);
      await driver.tap(Keys.myProfileHeaderExperienceInYearOptionChoice);
      await driver.tap(Keys.myProfileHeaderSaveButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await Future.delayed(const Duration(seconds: 2), (){});
    });

  });

}

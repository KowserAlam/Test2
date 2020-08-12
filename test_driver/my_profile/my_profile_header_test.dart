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
      await driver.tap(keys.signInEmail);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(keys.signInPassword);
      await driver.enterText('1234567s');
      await driver.tap(keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await driver.tap(keys.onboardingPageSkipButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await driver.tap(keys.bottomNavigationBarMyProfile);
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check if edit profile header button is working', () async {
      await driver.tap(keys.myProfileHeaderEditButton);
      await expect(await driver.getText(keys.myProfileHeaderAppbarTitle), 'Edit Profile');
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
      await driver.tap(keys.myProfileHeaderFullNameField);
      await driver.enterText('Test Full Name');
      await driver.tap(keys.myProfileHeaderMobileField);
      await driver.enterText('01711111111');
      await driver.tap(keys.myProfileHeaderSaveButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await expect(await driver.getText(keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(keys.myProfileHeaderName), 'Test Full Name');
      await expect(await driver.getText(keys.myProfileHeaderPhone), '01711111111');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check Description can be saved and showing', () async {
      await driver.tap(keys.myProfileHeaderEditButton);
      await driver.tap(keys.myProfileHeaderDescriptionField);
      await driver.enterText('Test Description');
      await driver.tap(keys.myProfileHeaderSaveButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await expect(await driver.getText(keys.myProfileAppbarTitle), 'My Profile');
      //await expect(keys.myProfileHeaderDescription, 'Test Description');
      await Future.delayed(const Duration(seconds: 5), (){});
    });
//
//    test('Check Current Company can be saved and showing', () async {
//      await driver.tap(keys.myProfileHeaderEditButton);
//      await driver.tap(keys.myProfileHeaderCurrentCompanyField);
//      await driver.enterText('Test Company');
//      await driver.tap(keys.myProfileHeaderSaveButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
//      await expect(await driver.getText(keys.myProfileAppbarTitle), 'My Profile');
//      await expect(await driver.getText(keys.myProfileHeaderCompany), 'Test Company');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
//
//    test('Check Current Designation can be saved and showing', () async {
//      await driver.tap(keys.myProfileHeaderEditButton);
//      await driver.scrollUntilVisible(keys.myProfileHeaderScrollView, keys.myProfileHeaderCurrentDesignationField, dyScroll: -40);
//      await driver.tap(keys.myProfileHeaderCurrentDesignationField);
//      await driver.enterText('Test Designation');
//      await driver.tap(keys.myProfileHeaderSaveButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
//      await expect(await driver.getText(keys.myProfileAppbarTitle), 'My Profile');
//      await expect(await driver.getText(keys.myProfileHeaderDesignation), 'Test Designation');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
//
//    test('Check Current Location can be saved and showing', () async {
//      await driver.tap(keys.myProfileHeaderEditButton);
//      await driver.scrollUntilVisible(keys.myProfileHeaderScrollView, keys.myProfileHeaderLocationField, dyScroll: -50);
//      await driver.tap(keys.myProfileHeaderLocationField);
//      await driver.enterText('Test Location');
//      await driver.tap(keys.myProfileHeaderSaveButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
//      await expect(await driver.getText(keys.myProfileAppbarTitle), 'My Profile');
//      await expect(await driver.getText(keys.myProfileHeaderLocation), 'Test Location');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });

  });

}

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

    test('Try to save while only company is filled from our list of companies', () async {
      await driver.tap(Keys.experienceJoiningDate);
      print('click 1');
      await Future.delayed(const Duration(seconds: 3), (){});
      print('click 2');
      await driver.tap(Keys.doneButtonKey);
      await driver.tap(Keys.workExperienceSaveButton);
      //await expect(await driver.getText(Keys.workExperienceAppbarTitleKey), 'Work Experience');
      await Future.delayed(const Duration(seconds: 10), (){});
    });



  });

}

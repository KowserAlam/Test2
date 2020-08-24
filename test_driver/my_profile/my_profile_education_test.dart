import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


//flutter drive --flavor dev --target=test_driver/my_profile/my_profile_membership.dart

void main() {
  group('My Profile - Education Test', () {


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
//      await Future.delayed(const Duration(seconds: 5), (){});
//      await driver.tap(Keys.onboardingPageSkipButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await driver.tap(Keys.bottomNavigationBarMyProfile);
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check add button is working', () async {
      await driver.scrollUntilVisible(Keys.myProfileScrollView, Keys.myProfileEducationPenKey, dyScroll: -100);
      await driver.tap(Keys.myProfileEducationPenKey);
      await driver.tap(Keys.myProfileEducationAddKey);
      await expect(await driver.getText(Keys.educationAppbarTitle), 'Education');
      await Future.delayed(const Duration(seconds: 3), (){});
    });

    test('Try to save while all fields are empty', () async {
      await driver.tap(Keys.educationSaveButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(Keys.educationAppbarTitle), 'Education');
    });



  });

}

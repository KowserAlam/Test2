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
      await driver.tap(keys.signInEmail);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(keys.signInPassword);
      await driver.enterText('1234567s');
      await driver.tap(keys.signInButton);
//      await Future.delayed(const Duration(seconds: 3), (){});
//      await driver.tap(keys.onboardingPageSkipButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await driver.tap(keys.bottomNavigationBarMyProfile);
      await Future.delayed(const Duration(seconds: 5), (){});
      await expect(await driver.getText(keys.myProfileAppbarTitle), 'My Profile');
    });

    test('Get to edit experience screen', () async {
      await driver.scrollUntilVisible(keys.myProfileScrollView, keys.myProfileExperiencePenKey, dyScroll: -20);
      await driver.tap(keys.myProfileExperiencePenKey);
      await driver.tap(keys.myProfileExperienceAddKey);
      await expect(await driver.getText(keys.workExperienceAppbarTitleKey), 'Work Experience');
      await Future.delayed(const Duration(seconds: 5), (){});
    });



  });

}

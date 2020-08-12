import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';

void main() {
  group('My Profile - Professional Skill Test', () {

    //flutter drive --flavor dev --target=test_driver/my_profile/my_profile_skill.dart

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
    test('Getting to Dashboard', () async {
      await driver.tap(keys.signInEmail);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(keys.signInPassword);
      await driver.enterText('1234567s');
      await driver.tap(keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await driver.tap(keys.onboardingPageSkipButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await driver.tap(keys.bottomNavigationBarMyProfile);
      await expect(await driver.getText(keys.myProfileAppbarTitle), 'My Profile');
    });

    test('Getting to Skill Add screen', () async {
      await driver.tap(keys.myProfileAddSkillPen);
      await driver.tap(keys.myProfileAddSkillAdd);
      await expect(await driver.getText(keys.professionalSkillAppbarTitle), 'Professional Skills');
    });

    test('Try to save while all fields are empty', () async {
      await driver.tap(keys.skillSaveButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(keys.professionalSkillAppbarTitle), 'Professional Skills');
    });
//
//    test('Try to save with only skill name written', () async {
//      await driver.tap(skillAddField);
//      await driver.enterText('python');
//      await driver.tap(skillSaveButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
//
//    test('Try to save with only skill expertise gievn more than 10', () async {
//      await driver.tap(skillAddField);
//      await driver.enterText('python');
//      await driver.tap(skillExpertise);
//      await driver.enterText('15');
//      await driver.tap(skillSaveButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });


//    test('Try to save skill Python with expertise level 10.', () async {
//      await driver.tap(skillExpertise);
//      await driver.enterText('10');
//      await driver.tap(skillAddField);
//      await driver.enterText('Python');
//      await driver.tap(skillSaveButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
  });

}

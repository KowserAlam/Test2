import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';

void main() {
  group('My Profile - Professional Portfolio Test', () {

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
      await driver.tap(Keys.signInEmail);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567s');
      await driver.tap(Keys.signInButton);
//      await Future.delayed(const Duration(seconds: 3), (){});
//      await driver.tap(keys.onboardingPageSkipButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await driver.tap(Keys.bottomNavigationBarMyProfile);
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
    });

    test('Getting to Skill Add screen', () async {
      await driver.scrollUntilVisible(Keys.myProfileScrollView, Keys.myProfilePortfolioPenKey, dyScroll: -50);
      await driver.tap(Keys.myProfilePortfolioPenKey);
      await driver.tap(Keys.myProfilePortfolioAddKey);
      await expect(await driver.getText(Keys.portfolioAppbarTitle), 'Portfolio');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

//    test('Try to save while all fields are empty', () async {
//      await driver.tap(Keys.skillSaveButton);
//      await Future.delayed(const Duration(seconds: 2), (){});
//      await expect(await driver.getText(Keys.professionalSkillAppbarTitle), 'Professional Skills');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });


  });

}

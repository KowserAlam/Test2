import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';

void main() {
  group('My Profile - Professional Skill Test', () {
    final myProfileHeaderEditButton = find.byValueKey('dashBoardListview');





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
    test('Getting to My Profile', () async {
      await driver.tap(keys.signInEmail);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(keys.signInPassword);
      await driver.enterText('1234567s');
      await driver.tap(keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await driver.tap(keys.onboardingPageSkipButton);
      await Future.delayed(const Duration(seconds: 20), (){});
      await driver.tap(keys.bottomNavigationBarMyProfile);
    });

    test('Getting to Skill Add screen', () async {
      await driver.tap(keys.myProfileHeaderEditButton);
      await Future.delayed(const Duration(seconds: 20), (){});
      await driver.tap(keys.myProfileHeaderFullName);
      await driver.enterText('Test Full Name');
      await driver.tap(keys.myProfileHeaderDescription);
      await driver.enterText('Test Description');
      //await driver.tap(keys.myProfileHeaderExperiencePerYear);
      await driver.tap(keys.myProfileHeaderMobile);
      await driver.enterText('01724232884');
      await driver.tap(keys.myProfileHeaderCurrentCompany);
      await driver.enterText('Test Company');
      await driver.tap(keys.myProfileHeaderCurrentDesignation);
      await driver.enterText('Test Designation');
      await driver.tap(keys.myProfileHeaderLocation);
      await driver.enterText('Test Location');
//      await driver.tap(keys.myProfileHeaderFacebook);
//      await driver.enterText('');
//      await driver.tap(keys.myProfileHeaderTwitter);
//      await driver.enterText('');
//      await driver.tap(keys.myProfileHeaderLinkedIn);
//      await driver.enterText('');
      //await driver.tap(keys.myProfileHeaderSaveButton);
    });

  });

}

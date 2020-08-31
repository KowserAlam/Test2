import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';
import 'my_profile_certifications_test.dart';
import 'my_profile_education_test.dart';
import 'my_profile_experience_test.dart';
import 'my_profile_header_test.dart';
import 'my_profile_membership_test.dart';
import 'my_profile_personal_info_test.dart';
import 'my_profile_portfolio_test.dart';
import 'my_profile_references_test.dart';

//flutter drive --flavor dev --target=test_driver/my_profile/my_profile_all_tests.dart


main() {
  allTestCaseAtOnce();
}

Future<void> allTestCaseAtOnce() async {
  group('All My Profile Test Cases: ', () {
    final jobListSearchToggleButtonKey =
    find.byValueKey('jobListSearchToggleButtonKey');
    final jobListSearchInputFieldKey =
    find.byValueKey('jobListSearchInputFieldKey');
    final jobListSearchButtonKey = find.byValueKey('jobListSearchButtonKey');

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
      await driver.enterText('example@jobxprss.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), (){});
//      await driver.tap(Keys.onboardingPageSkipButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
      await driver.tap(Keys.bottomNavigationBarMyProfile);
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    myProfileHeaderTest();

    myProfileExperienceTest();

    myProfileEducationTest();

    myProfilePortfolioTest();

    myProfileCertificationTest();

    myProfileMembershipTest();

    myProfileReferencesTest();

    myProfilePersonalInfoTest();


  });
}

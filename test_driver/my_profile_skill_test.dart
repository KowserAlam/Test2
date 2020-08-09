import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('My Profile - Professional Skill Test', () {
    final onboardingPageSkipButton = find.byValueKey('onboardingPageSkipButton');
    final signInEmail = find.byValueKey('signInEmail');
    final signInPassword = find.byValueKey('signInPassword');
    final signInButton = find.byValueKey('signInButton');
    final bottomNavigationBarMyProfile = find.byValueKey('bottomNavigationBarMyProfile');
    final myProfileAddSkillPen = find.byValueKey('myProfileAddSkillPen');
    final myProfileAddSkillAdd = find.byValueKey('myProfileAddSkillAdd');
    final skillAddField = find.byValueKey('skillAddField');
    final skillExpertise = find.byValueKey('skillExpertise');
    final skillSaveButton = find.byValueKey('skillSaveButton');
    final dashBoardContactUsTile = find.byValueKey('dashBoardContactUsTile');
    final dashBoardListview = find.byValueKey('dashBoardListview');





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
      await driver.tap(signInEmail);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(signInPassword);
      await driver.enterText('1234567s');
      await driver.tap(signInButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await driver.tap(onboardingPageSkipButton);
      await Future.delayed(const Duration(seconds: 30), (){});
    });

    test('Click on contact us tile', () async {
      await driver.scrollUntilVisible(dashBoardListview, dashBoardContactUsTile, dyScroll: -600);
      await Future.delayed(const Duration(seconds: 10), (){});
    });

//    test('Try to save while all fields are empty', () async {
//      await driver.tap(skillSaveButton);
//      await Future.delayed(const Duration(seconds: 10), (){});
//    });
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
//      await driver.enterText('');
//      await driver.tap(skillExpertise);
//      await driver.enterText('15');
//      await driver.tap(skillSaveButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
//
//    test('Try to save with only skill expertise gievn 5', () async {
//      await driver.tap(skillExpertise);
//      await driver.enterText('5');
//      await driver.tap(skillSaveButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
//
//    test('Try to save skill Python with expertise level 10.', () async {
//      await driver.tap(skillAddField);
//      await driver.enterText('Python');
//      await driver.tap(skillExpertise);
//      await driver.enterText('10');
//      await driver.tap(skillSaveButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
  });

}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';

main(){
  myProfileSkillTest();
}
Future<void> myProfileSkillTest()async{
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
      await driver.scrollUntilVisible(Keys.myProfileScrollView, Keys.myProfileAddSkillPen, dyScroll: -50);
      await driver.tap(Keys.myProfileAddSkillPen);
      await driver.tap(Keys.myProfileAddSkillAdd);
      await expect(await driver.getText(Keys.professionalSkillAppbarTitle), 'Professional Skills');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Try to save while all fields are empty', () async {
      await driver.tap(Keys.skillSaveButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(Keys.professionalSkillAppbarTitle), 'Professional Skills');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Try to save with only skill name written', () async {
      await driver.tap(Keys.skillAddField);
      await driver.enterText('python');
      await driver.tap(Keys.skillSaveButton);
      await expect(await driver.getText(Keys.professionalSkillAppbarTitle), 'Professional Skills');
      await Future.delayed(const Duration(seconds: 5), (){});
    });
//
    test('Try to save with only skill expertise gievn more than 10', () async {
      await driver.tap(Keys.skillExpertise);
      await driver.enterText('15');
      await driver.tap(Keys.skillSaveButton);
      await expect(await driver.getText(Keys.professionalSkillAppbarTitle), 'Professional Skills');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Try to save with only skill expertise gievn 0', () async {
      await driver.tap(Keys.skillExpertise);
      await driver.enterText('0');
      await driver.tap(Keys.skillSaveButton);
      await expect(await driver.getText(Keys.professionalSkillAppbarTitle), 'Professional Skills');
      await Future.delayed(const Duration(seconds: 5), (){});
    });


//    test('Check if edit is working', () async {
//      await driver.tap(keys.skillEditButton);
//      await driver.tap(keys.skillExpertise);
//      await driver.enterText('10');
//      await driver.tap(keys.skillSaveButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
//      await expect(await driver.getText(keys.myProfileAppbarTitle), 'My Profile');
//    });

//    test('Adding a second skill to check delete', () async {
//      //await driver.tap(keys.myProfileAddSkillPen);
//      await driver.tap(keys.myProfileAddSkillAdd);
//      await expect(await driver.getText(keys.professionalSkillAppbarTitle), 'Professional Skills');
//      await driver.tap(keys.skillAddField);
//      await driver.enterText('dart');
//      await driver.tap(keys.skillExpertise);
//      await driver.enterText('10');
//      await driver.tap(keys.skillSaveButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
//      await expect(await driver.getText(keys.myProfileAppbarTitle), 'My Profile');
//      await expect(await driver.getText(keys.addedTileSkillName), 'Dart');
//      await Future.delayed(const Duration(seconds: 10), (){});
//    });

//    test('Check if delete is working', () async {
//      await driver.tap(keys.skillDeleteButton);
//      await Future.delayed(const Duration(seconds: 5), (){});
//      await driver.tap(keys.myProfileDialogBoxDeleteTile);
//      await Future.delayed(const Duration(seconds: 5), (){});
//      await expect(await driver.getText(keys.myProfileAppbarTitle), 'My Profile');
//      await expect(await driver.getText(keys.tileSkillName), 'Dart');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
  });

}

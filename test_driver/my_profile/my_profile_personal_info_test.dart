import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


//flutter drive --flavor dev --target=test_driver/my_profile/my_profile_personal_info.dart
//flutter drive --target=test_driver/my_profile/my_profile_personal_info.dart -d macOS

void main() {
  myProfilePersonalInfoTest();
}

Future<void> myProfilePersonalInfoTest()async{
  group('My Profile - Personal Info Test', () {


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
    test('login with registered email and password', () async {
      await driver.tap(Keys.signInEmail);
      await driver.enterText('mahmudoni01@gmail.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButton);
      await Future.delayed(const Duration(seconds: 10), () {});
    });

    test('Check edit button is working', () async {
      await driver.scrollUntilVisible(Keys.myProfileScrollView, Keys.personalInfoPenKey, dyScroll: -200);
      await driver.tap(Keys.personalInfoPenKey);
      await Future.delayed(const Duration(seconds: 4), (){});
      await expect(await driver.getText(Keys.personalInfoAppbarTitle), 'Personal Information');
    });

    test('Try to save father\'s name', () async {
      await driver.tap(Keys.personalInfoFatherName);
      await driver.enterText('Test Father Name');
      await driver.tap(Keys.personalInfoSaveButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.personalInfoTileFatherName), 'Test Father Name');
    });

    test('Try to save mother\'s name', () async {
      await driver.tap(Keys.personalInfoPenKey);
      await driver.tap(Keys.personalInfoMotherName);
      await driver.enterText('Test Mother Name');
      await driver.tap(Keys.personalInfoSaveButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.personalInfoTileMotherName), 'Test Mother Name');
    });

    test('Try to save current address', () async {
      await driver.tap(Keys.personalInfoPenKey);
      await driver.tap(Keys.personalInfoCurrentAddress);
      await driver.enterText('Test Current Address');
      await driver.tap(Keys.personalInfoSaveButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.personalInfoTileCurrentAddress), 'Test Current Address');
    });

    test('Try to save permanent address', () async {
      await driver.tap(Keys.personalInfoPenKey);
      await driver.tap(Keys.personalInfoPermanentAddress);
      await driver.enterText('Test Permanent Address');
      await driver.tap(Keys.personalInfoSaveButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.personalInfoTilePermanentAddress), 'Test Permanent Address');
    });

    test('Try to save Nationality', () async {
      await driver.tap(Keys.personalInfoPenKey);
      await driver.scrollUntilVisible(Keys.myProfileScrollView, Keys.personalInfoNationality, dyScroll: -100);
      await driver.tap(Keys.personalInfoNationality);
      await driver.scrollUntilVisible(Keys.bangladeshi, find.text('Bangladeshi'), dyScroll: -2);
      await driver.tap(Keys.personalInfoSaveButton);
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
    });

    test('Try to save Relegion', () async {
      await driver.tap(Keys.personalInfoPenKey);
      await driver.scrollUntilVisible(Keys.myProfileScrollView, Keys.personalInfoReligion, dyScroll: -100);
      await driver.tap(Keys.personalInfoReligion);
      await driver.scrollUntilVisible(Keys.islam, find.text('Islam'), dyScroll: -2);
      await driver.tap(Keys.personalInfoSaveButton);
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
    });

    test('Try to save Blood Group O+', () async {
      await driver.tap(Keys.personalInfoPenKey);
      await driver.scrollUntilVisible(Keys.myProfileScrollView, Keys.personalInfoBloodGroup, dyScroll: -100);
      await driver.tap(Keys.personalInfoBloodGroup);
      await driver.scrollUntilVisible(Keys.bloodGroupOplus, find.text('O+'), dyScroll: -2);
      await driver.tap(Keys.personalInfoSaveButton);
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
    });
    test('Try to save Blood Group (select B+ first, confirm A+, after)', () async {
      await driver.tap(Keys.personalInfoPenKey);
      await driver.scrollUntilVisible(Keys.myProfileScrollView, Keys.personalInfoBloodGroup, dyScroll: -100);
      await driver.tap(Keys.personalInfoBloodGroup);
      await driver.scrollUntilVisible(Keys.bloodGroupBplus, find.text('B+'), dyScroll: -2);
      await driver.tap(Keys.personalInfoBloodGroup);
      await driver.scrollUntilVisible(Keys.bloodGroupAplus, find.text('A+'), dyScroll: -2);
      await driver.tap(Keys.personalInfoSaveButton);
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
    });

  });
}

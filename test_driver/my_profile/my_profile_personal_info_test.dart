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
    test('Check edit button is working', () async {
      await driver.scrollUntilVisible(Keys.myProfileScrollView, Keys.personalInfoPenKey, dyScroll: -200);
      await driver.tap(Keys.personalInfoPenKey);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(Keys.personalInfoAppbarTitle), 'Personal Information');
    });

    test('Try to save father\'s name', () async {
      await driver.tap(Keys.personalInfoFatherName);
      await driver.enterText('Test Father Name');
      await driver.tap(Keys.personalInfoSaveButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.personalInfoTileFatherName), 'Test Father Name');
    });

    test('Try to save mother\'s name', () async {
      await driver.tap(Keys.personalInfoPenKey);
      await driver.tap(Keys.personalInfoMotherName);
      await driver.enterText('Test Mother Name');
      await driver.tap(Keys.personalInfoSaveButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.personalInfoTileMotherName), 'Test Mother Name');
    });

    test('Try to save current address', () async {
      await driver.tap(Keys.personalInfoPenKey);
      await driver.tap(Keys.personalInfoCurrentAddress);
      await driver.enterText('Test Current Address');
      await driver.tap(Keys.personalInfoSaveButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.personalInfoTileCurrentAddress), 'Test Current Address');
    });

    test('Try to save permanent address', () async {
      await driver.tap(Keys.personalInfoPenKey);
      await driver.tap(Keys.personalInfoPermanentAddress);
      await driver.enterText('Test Permanent Address');
      await driver.tap(Keys.personalInfoSaveButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.personalInfoTilePermanentAddress), 'Test Permanent Address');
    });

//    test('Try to save gender', () async {
//      await driver.tap(Keys.personalInfoPenKey);
//      print('1');
//      await driver.tap(Keys.personalInfoGender);
//      await driver.waitFor(Keys.personalInfoGender);
////      await Future.delayed(const Duration(seconds: 1), (){});
//      print('2');
//      await driver.tap(Keys.personalInfoGenderMale);
//      print('3');
//      await driver.tap(Keys.personalInfoSaveButton);
//
//      await Future.delayed(const Duration(seconds: 2), (){});
//      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
//      await expect(await driver.getText(Keys.personalInfoTileGender), 'Male');
//    });

//    test('Try to save nationality', () async {
//      await driver.tap(Keys.personalInfoPenKey);
//      await driver.scrollUntilVisible(Keys.personalInfoScrollView, Keys.personalInfoNationality, dyScroll: -20);
//      await driver.tap(Keys.personalInfoNationality);
//      await driver.tap(Keys.personalInfoNationalityBangladeshi);
//      await driver.tap(Keys.personalInfoSaveButton);
//      await Future.delayed(const Duration(seconds: 2), (){});
//      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
//      await expect(await driver.getText(Keys.personalInfoTileGender), 'Bangladeshi');
//    });
//
//    test('Try to save religion', () async {
//      await driver.tap(Keys.personalInfoPenKey);
//      await driver.scrollUntilVisible(Keys.personalInfoScrollView, Keys.personalInfoReligion, dyScroll: -20);
//      await driver.tap(Keys.personalInfoReligion);
//      await driver.tap(Keys.personalInfoReligionIslam);
//      await driver.tap(Keys.personalInfoSaveButton);
//      await Future.delayed(const Duration(seconds: 2), (){});
//      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
//      await expect(await driver.getText(Keys.personalInfoTileReligion), 'Islam');
//    });
//
//    test('Try to save blood group', () async {
//      await driver.tap(Keys.personalInfoPenKey);
//      await driver.scrollUntilVisible(Keys.personalInfoScrollView, Keys.personalInfoBloodGroup, dyScroll: -20);
//      await driver.tap(Keys.personalInfoBloodGroup);
//      await driver.tap(Keys.personalInfoBloodGroupAPositive);
//      await driver.tap(Keys.personalInfoSaveButton);
//      await Future.delayed(const Duration(seconds: 2), (){});
//      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
//      await expect(await driver.getText(Keys.personalInfoTileReligion), 'A+');
//    });


  });
}

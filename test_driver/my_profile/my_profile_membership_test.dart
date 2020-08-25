import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


//flutter drive --flavor dev --target=test_driver/my_profile/my_profile_membership.dart

main(){
  myProfileMembershipTest();
}
Future<void> myProfileMembershipTest()async{
  group('My Profile - Membership Test', () {


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
     test('Check add button is working', () async {
      await driver.scrollUntilVisible(Keys.myProfileScrollView, Keys.myProfileMembershipPenKey, dyScroll: -100);
      await driver.tap(Keys.myProfileMembershipPenKey);
      await driver.tap(Keys.myProfileMembershipAddKey);
      await expect(await driver.getText(Keys.membershipAppbarTitle), 'Membership');
      await Future.delayed(const Duration(seconds: 3), (){});
    });

    test('Try to save while all fields are empty', () async {
      await driver.tap(Keys.membershipSaveButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await expect(await driver.getText(Keys.membershipAppbarTitle), 'Membership');
    });

    test('Try to save after filling  Organization name', () async {
      await driver.tap(Keys.membershipOrganizationName);
      await driver.enterText('Test Organization Name');
      await driver.tap(Keys.membershipSaveButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await expect(await driver.getText(Keys.membershipAppbarTitle), 'Membership');
    });

    test('Try to save after starting date selected', () async {
      await driver.tap(Keys.membershipStartDate);
      await driver.tap(Keys.doneButtonKey);
      await driver.tap(Keys.membershipSaveButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.membershipTileOrganizationName), 'Test Organization Name');
    });

    test('Check if edit is working', () async {
      await driver.tap(Keys.membershipEditKey);
      await driver.tap(Keys.membershipOrganizationName);
      await driver.enterText('Test Organization Name Edited');
      await driver.tap(Keys.membershipSaveButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.membershipTileOrganizationName), 'Test Organization Name Edited');
    });

    test('Try to save while all fields are filled', () async {
      await driver.tap(Keys.membershipEditKey);
      await driver.tap(Keys.membershipPositionHeld);
      await driver.enterText('Test Position Held');
      await driver.tap(Keys.membershipDescription);
      await driver.enterText('Test Description');
      await driver.tap(Keys.membershipSaveButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.membershipTilePositionHeld), 'Test Position Held');
    });

    test('Try to save after checkbox is unselected', () async {
      await driver.tap(Keys.membershipEditKey);
      await driver.tap(Keys.membershipOngoing);
      await driver.tap(Keys.membershipSaveButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await expect(await driver.getText(Keys.membershipAppbarTitle), 'Membership');
    });

    test('Try to save after end date is selected', () async {
      await driver.tap(Keys.membershipEndDate);
      await driver.scrollUntilVisible(Keys.datePikerKey, find.text("2022"), dyScroll: -3);
      await driver.tap(Keys.doneButtonKey);
      await driver.tap(Keys.membershipSaveButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.membershipTileOrganizationName), 'Test Organization Name Edited');
    });

    test('Adding a second entry to check delete', () async {
      await driver.tap(Keys.myProfileMembershipAddKey);
      await driver.tap(Keys.membershipOrganizationName);
      await driver.enterText('Test Organization Name 2');
      await driver.tap(Keys.membershipStartDate);
      await driver.tap(Keys.doneButtonKey);
      await driver.tap(Keys.membershipSaveButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.addedMembershipTileOrganizationName), 'Test Organization Name 2');
    });

    test('Check if delete is working with confirmation pop up', () async {
      await driver.tap(Keys.membershipDeleteKey);
      await driver.tap(Keys.myProfileDialogBoxDeleteTile);
      await expect(await driver.getText(Keys.membershipTileOrganizationName), 'Test Organization Name 2');
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
    });

  });

}

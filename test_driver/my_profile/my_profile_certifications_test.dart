import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


//flutter drive --flavor dev --target=test_driver/my_profile/my_profile_certifications.dart

main(){
  myProfileCertificationTest();
}
Future<void> myProfileCertificationTest()async{
  group('My Profile - Certifications Test', () {


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
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567s');
      await driver.tap(Keys.signInButton);
//      await Future.delayed(const Duration(seconds: 3), (){});
//      await driver.tap(keys.onboardingPageSkipButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await driver.tap(Keys.bottomNavigationBarMyProfile);
      await Future.delayed(const Duration(seconds: 5), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
    });

    test('Get to edit certification screen', () async {
      await driver.scrollUntilVisible(Keys.myProfileScrollView, Keys.myProfileCertificationPenKey, dyScroll: -50);
      await driver.tap(Keys.myProfileCertificationPenKey);
      await driver.tap(Keys.myProfileCertificationAddKey);
      await expect(await driver.getText(Keys.certificationAppbarTitle), 'Certifications');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Try to save while all fields are empty', () async {
      await driver.tap(Keys.certificationSaveButton);
      await expect(await driver.getText(Keys.certificationAppbarTitle), 'Certifications');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Try to save with only certification name', () async {
      await driver.tap(Keys.certificationName);
      await driver.enterText('Test Certification Name');
      await driver.tap(Keys.certificationSaveButton);
      await expect(await driver.getText(Keys.certificationAppbarTitle), 'Certifications');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Try to save with issue date', () async {
      await driver.tap(Keys.certificationIssueDate);
      await Future.delayed(const Duration(seconds: 3), (){});
      await driver.tap(Keys.doneButtonKey);
      await driver.tap(Keys.certificationSaveButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.certificationTileNameKey), 'Test Certification Name');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check if edit is working.', () async {
      await driver.tap(Keys.certificationEditKey);
      await driver.tap(Keys.certificationName);
      await driver.enterText('Test Certification Name Edited');
      await driver.tap(Keys.certificationSaveButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.certificationTileNameKey), 'Test Certification Name Edited');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Try to save after checkbox is checked', () async {
      await driver.tap(Keys.certificationEditKey);
      await driver.tap(Keys.certificationHasExpiryDate);
      await driver.tap(Keys.certificationSaveButton);
      await expect(await driver.getText(Keys.certificationAppbarTitle), 'Certifications');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('After checkbox checked end date is mandatory', () async {
      await driver.tap(Keys.certificationExpiryDate);
      await driver.scrollUntilVisible(Keys.datePikerKey, find.text("2022"), dyScroll: -3);
      await driver.tap(Keys.doneButtonKey);
      await Future.delayed(const Duration(seconds: 2), (){});
      await driver.tap(Keys.certificationSaveButton);
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check Organization name can be saved', () async {
      await driver.tap(Keys.certificationEditKey);
      await driver.tap(Keys.certificationOrganizationName);
      await driver.enterText('Test Certification Organization Name');
      await driver.tap(Keys.certificationSaveButton);
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.certificationTileOrganizationNameKey), 'Test Certification Organization Name');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check if credential id can be saved', () async {
      await driver.tap(Keys.certificationEditKey);
      await driver.tap(Keys.certificationCredentialIdName);
      await driver.enterText('Test Certification Credential ID');
      await driver.tap(Keys.certificationSaveButton);
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check if credential url can be saved', () async {
      await driver.tap(Keys.certificationEditKey);
      await driver.tap(Keys.certificationCredentialUrl);
      await driver.enterText('Test Certification Credential URL');
      await driver.tap(Keys.certificationSaveButton);
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Add a second entry to check delete', () async {
      await driver.tap(Keys.myProfileCertificationAddKey);
      await driver.tap(Keys.certificationName);
      await driver.enterText('Test Certification Name 2');
      await driver.tap(Keys.certificationIssueDate);
      await Future.delayed(const Duration(seconds: 3), (){});
      await driver.tap(Keys.doneButtonKey);
      await driver.tap(Keys.certificationSaveButton);
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.addedCertificationTileNameKey), 'Test Certification Name 2');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check if delete is working', () async {
      await driver.tap(Keys.certificationDeleteKey);
      await driver.tap(Keys.myProfileDialogBoxDeleteTile);
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.certificationTileNameKey), 'Test Certification Name 2');
      await Future.delayed(const Duration(seconds: 5), (){});
    });




//    test('Check if designation can be saved', () async {
//      await driver.tap(Keys.experienceEditButton);
//      await driver.tap(Keys.experienceDesignationKey);
//      await driver.enterText('Test Designation');
////      await driver.tap(Keys.experienceDescriptionKey);
////      await driver.enterText('Test Description');
//      await Future.delayed(const Duration(seconds: 3), (){});
//      await driver.tap(Keys.workExperienceSaveButton);
//      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
//      await expect(await driver.getText(Keys.experienceTileDesignation), 'Test Designation');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });

//    test('Check if description can be saved & showing', () async {
//      await driver.tap(Keys.experienceEditButton);
//      await driver.tap(Keys.experienceDescriptionKey);
//      await driver.enterText('Test Description');
//      await Future.delayed(const Duration(seconds: 3), (){});
//      await driver.tap(Keys.workExperienceSaveButton);
//      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
//
//    test('Try to save after filled leaving date', () async {
//      await driver.tap(Keys.experienceEditButton);
//      await driver.tap(Keys.experienceCurrentlyWorkingKey);
//      await driver.tap(Keys.experienceLeavingDate);
//      await Future.delayed(const Duration(seconds: 3), (){});
//      await driver.tap(Keys.doneButtonKey);
//      await driver.tap(Keys.workExperienceSaveButton);
//      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
//
//    test('Add a new entry to test if delete is working', () async {
//      await driver.tap(Keys.myProfileExperienceAddKey);
//      await driver.tap(Keys.experienceCompanyName);
//      await driver.enterText('Test Company');
//      await driver.tap(Keys.experienceJoiningDate);
//      await Future.delayed(const Duration(seconds: 3), (){});
//      await driver.tap(Keys.doneButtonKey);
//      await driver.tap(Keys.experienceCurrentlyWorkingKey);
//      await driver.tap(Keys.workExperienceSaveButton);
//      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
//      await expect(await driver.getText(Keys.experienceTileCompanyName), 'Test Company');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });
//
//    test('Check if delete is working', () async {
//      await expect(await driver.getText(Keys.experienceTileCompanyName), 'Ishraak Solutions');
//      await driver.tap(Keys.experienceDeleteButton);
//      await driver.tap(Keys.myProfileDialogBoxDeleteTile);
//      await expect(await driver.getText(Keys.experienceTileCompanyName), 'Test Company');
//      await Future.delayed(const Duration(seconds: 5), (){});
//    });


  });

}

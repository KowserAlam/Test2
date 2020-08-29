import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';

//flutter drive --flavor dev --target=test_driver/jobs_segment/change_password.dart


main() {
  allTestCaseAtOnce();
}

Future<void> allTestCaseAtOnce() async {

  group('Change Password Tests', () {

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
    test('Getting to Change Password screen', () async {
      await driver.tap(Keys.signInEmail);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567d');
      await driver.tap(Keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await driver.tap(Keys.bottomNavigationBarMyProfile);
      await driver.tap(Keys.myProfileSettingsButton);
      await expect(await driver.getText(Keys.settingsAppbarTitle), 'Settings');
      await driver.tap(Keys.settingsChangePassword);
      await expect(await driver.getText(Keys.changePasswordAppbarTitle), 'Change Password');
      await Future.delayed(const Duration(seconds: 5), (){});
    });


    test('Check with wrong old password', () async {
      await driver.tap(Keys.changePasswordOldPassword);
      await driver.enterText('12345678');
      await driver.tap(Keys.changePasswordNewPassword);
      await driver.enterText('1234567d');
      await driver.tap(Keys.changePasswordConfirmPassword);
      await driver.enterText('1234567d');
      await driver.tap(Keys.changePasswordSubmitButton);
      await expect(await driver.getText(Keys.changePasswordAppbarTitle), 'Change Password');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check with wrong password format', () async {
      await driver.tap(Keys.changePasswordOldPassword);
      await driver.enterText('1234567d');
      await driver.tap(Keys.changePasswordNewPassword);
      await driver.enterText('12345678');
      await driver.tap(Keys.changePasswordConfirmPassword);
      await driver.enterText('12345678');
      await driver.tap(Keys.changePasswordSubmitButton);
      await expect(await driver.getText(Keys.changePasswordAppbarTitle), 'Change Password');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check with wrong confirm password', () async {
      await driver.tap(Keys.changePasswordNewPassword);
      await driver.enterText('1234567s');
      await driver.tap(Keys.changePasswordConfirmPassword);
      await driver.enterText('12345678');
      await driver.tap(Keys.changePasswordSubmitButton);
      await expect(await driver.getText(Keys.changePasswordAppbarTitle), 'Change Password');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Give proper information to update password', () async {
      await driver.tap(Keys.changePasswordNewPassword);
      await driver.enterText('1234567s');
      await driver.tap(Keys.changePasswordConfirmPassword);
      await driver.enterText('1234567s');
      await driver.tap(Keys.changePasswordSubmitButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(Keys.settingsAppbarTitle), 'Settings');
      await driver.tap(Keys.settingsSignOut);
      await driver.tap(Keys.myProfileDialogBoxDeleteTile);
      await expect(await driver.getText(Keys.signInWelcomeText), 'Welcome back!');
    });

    test('Check if password have been updated by logging in with updated password', () async {
      await driver.tap(Keys.signInEmail);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567s');
      await driver.tap(Keys.signInButton);
      await expect(await driver.getText(Keys.dashboardAppbardTitle), 'Dashboard');
    });

  });
}

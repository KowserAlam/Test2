import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


//flutter drive --flavor dev --target=test_driver/settings/other_settings.dart

main(){
  otherSettings();
}
Future<void> otherSettings()async{
  group('Other Settings Test: ', () {
    final backButton = find.byTooltip('Back');
    final emailSubscriptionAppBarText = find.byValueKey('emailSubscriptionAppBarText');
    final managePushNotificationAppBarText = find.byValueKey('managePushNotificationAppBarText');



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
    test('Getting to Settings screen', () async {
      await driver.tap(Keys.bottomNavigationBarMyProfile);
      await driver.tap(Keys.myProfileSettingsButton);
      await expect(await driver.getText(Keys.settingsAppbarTitle), 'Settings');
      await Future.delayed(const Duration(seconds: 3), (){});
    });

    test('Check push notification', () async {
      await driver.tap(Keys.pushNotificationTextKey);
      await expect(await driver.getText(managePushNotificationAppBarText), 'Manage push notification');
      await driver.tap(backButton);
    });

    test('Check Email Subscription', () async {
      await driver.tap(Keys.emailSubscriptionTextKey);
      await expect(await driver.getText(emailSubscriptionAppBarText), 'Email subscription');
      await driver.tap(backButton);
    });

    test('Check Clear cache data', () async {
      await driver.tap(Keys.clearCachedDataKey);
      await driver.tap(find.text('No'));
      await driver.tap(Keys.clearCachedDataKey);
      await driver.tap(find.text('Yes'));
      await driver.tap(backButton);
    });

    test('Check Signout', () async {
      await driver.tap(Keys.myProfileSettingsButton);
      await driver.tap(Keys.settingsSignOut);
      await driver.tap(find.text('No'));
      await driver.tap(Keys.settingsSignOut);
      await driver.tap(find.text('Yes'));
    });





  });

}

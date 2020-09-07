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
    final managePushNotificationToggleButton = find.byValueKey('managePushNotificationToggleButton');
    final subscribeEmailNotificationToggleButton = find.byValueKey('subscribeEmailNotificationToggleButton');
    final doYouWantToClearAllCacheTextKey = find.text('Do you want to clear all cache ?');
    final clearedTextToastKey = find.text('Cleared');



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
    /*test('login with registered email and password', () async {
      await driver.tap(Keys.signInEmail);
      await driver.enterText('mahmudoni01@gmail.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButton);
      await Future.delayed(const Duration(seconds: 5), () {});
    });*/

    test('Getting to Settings screen', () async {
      await driver.tap(Keys.bottomNavigationBarMyProfile);
      await Future.delayed(const Duration(seconds: 5), () {});
      await driver.tap(Keys.myProfileSettingsButton);
      await expect(await driver.getText(Keys.settingsAppbarTitle), 'Settings');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check push notification', () async {
      await driver.tap(Keys.pushNotificationTextKey);
      await expect(await driver.getText(managePushNotificationAppBarText), 'Manage push notification');
      await driver.tap(managePushNotificationToggleButton);
      await Future.delayed(const Duration(seconds: 5), () {});
      await driver.tap(managePushNotificationToggleButton);
      await Future.delayed(const Duration(seconds: 5), () {});
      await driver.tap(backButton);
    });

    test('Check Email Subscription', () async {
      await driver.tap(Keys.emailSubscriptionTextKey);
      await expect(await driver.getText(emailSubscriptionAppBarText), 'Email subscription');
      await driver.tap(subscribeEmailNotificationToggleButton);
      await Future.delayed(const Duration(seconds: 5), () {});
      await driver.tap(subscribeEmailNotificationToggleButton);
      await Future.delayed(const Duration(seconds: 5), () {});
      await driver.tap(backButton);
    });

    test('Check Clear cache data', () async {
      await driver.tap(Keys.clearCachedDataKey);
      await expect(await driver.getText(doYouWantToClearAllCacheTextKey), 'Do you want to clear all cache ?');
      await driver.tap(find.text('No'));
      await driver.tap(Keys.clearCachedDataKey);
      await expect(await driver.getText(doYouWantToClearAllCacheTextKey), 'Do you want to clear all cache ?');
      await driver.tap(find.text('Yes'));
      await driver.waitFor(clearedTextToastKey);
      await Future.delayed(const Duration(seconds: 5), () {});
      await driver.tap(backButton);
    });

    test('Check Signout', () async {
      await driver.tap(Keys.myProfileSettingsButton);
      await driver.tap(Keys.settingsSignOut);
      await driver.tap(Keys.commonPromptNo);
      await driver.tap(Keys.settingsSignOut);
      await driver.tap(Keys.commonPromptYes);
      await expect(await driver.getText(Keys.signInWelcomeText), 'Welcome back!');
    });





  });

}

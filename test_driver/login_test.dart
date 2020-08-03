import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


void main() {

  group('Login Test', () {

    final emailField = find.byValueKey('signInEmail');
    final passwordField = find.byValueKey('signInPassword');
    final buttonClick = find.byTooltip('signInButton');

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

    test('Not login with wrong email & password', () async {

      await driver.tap(emailField);
      await driver.enterText('example@ishraak.com');
      await driver.tap(passwordField);
      await driver.enterText('12345');
      await driver.tap(buttonClick);
      await driver.waitUntilNoTransientCallbacks();
    });

  });


}

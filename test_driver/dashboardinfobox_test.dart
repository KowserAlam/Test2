import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Dashboard Infobox', () {
    final signinEmailField = find.byValueKey('signInEmail');
    final signinPasswordField = find.byValueKey('signInPassword');
    final signinButtonClick = find.byValueKey('signInButton');
    final forgotPasswordLink = find.text('Forgot Password ?');
    final backButton = find.byTooltip('Back');
    final skipOnboardingScreen = find.text('Skip');

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

    test('Try to login with registered email and password', () async {
      await driver.tap(signinEmailField);
      await driver.enterText('mahmudoni01@gmail.com');
      await driver.tap(signinPasswordField);
      await driver.enterText('1234567r');
      await driver.tap(signinButtonClick);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
  });
}

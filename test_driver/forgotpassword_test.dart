import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Forgot Password test', () {
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
    test('Click on forgot password link from login page', () async {
      await driver.tap(forgotPasswordLink);
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(backButton);
    });
    test('Try to change password with wrong email format', () async {
      await driver.tap(forgotPasswordLink);
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(backButton);
    });

  });
}

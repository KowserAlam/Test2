import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Login Test', () {
    final onboardingPageBackArrow = find.byValueKey('onboardingPageBackArrow');
    final onboardingPageFrontArrow = find.byValueKey('onboardingPageFrontArrow');
    final onboardingPageContinueButton = find.byValueKey('onboardingPageContinueButton');

    final signInEmail = find.byValueKey('signInEmail');
    final signInPassword = find.byValueKey('signInPassword');
    final signInButton = find.byValueKey('signInButton');





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
    test('Logging in shows onboarding page', () async {
      await driver.tap(signInEmail);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(signInPassword);
      await driver.enterText('1234567s');
      await driver.tap(signInButton);
      await Future.delayed(const Duration(seconds: 3), (){});
    });
    test('Click next 2 times and finally click on Continue', () async {
      await driver.tap(onboardingPageFrontArrow);
      await driver.tap(onboardingPageFrontArrow);
      await driver.tap(onboardingPageContinueButton);
      await Future.delayed(const Duration(seconds: 2), (){});
    });
  });

}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('My Profile - Heading Section Test', () {
    final onboardingPageSkipButton = find.byValueKey('onboardingPageSkipButton');
    final signInEmail = find.byValueKey('signInEmail');
    final signInPassword = find.byValueKey('signInPassword');
    final signInButton = find.byValueKey('signInButton');
    final bottomNavigationBarMyProfile = find.byValueKey('bottomNavigationBarMyProfile');





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
    test('Getting to My Profile', () async {
      await driver.tap(signInEmail);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(signInPassword);
      await driver.enterText('1234567s');
      await driver.tap(signInButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await driver.tap(onboardingPageSkipButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await driver.tap(bottomNavigationBarMyProfile);
      await Future.delayed(const Duration(seconds: 5), (){});
    });
  });

}

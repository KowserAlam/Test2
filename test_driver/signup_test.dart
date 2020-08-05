import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


void main() {

  group('SignUp Test', () {

    final signUpButton = find.byValueKey('signUpButton');
    final skipOnboardingScreen = find.text('Skip');
    final findSigninButtonfromSignup = find.text('Sign In');
    //final emailErrorMessage = find.byType('errorTextEmail');
    //final passwordErrorMessage = find.byType('errorTextPassword');

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

    test('Go to signup page', () async {
      await driver.tap(signUpButton);
      await Future.delayed(const Duration(seconds: 2), (){});
    });


  });


}

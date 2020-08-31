import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../dashboard/dashboard_test.dart';

main(){
  loginTest();
}
 Future<void> loginTest()async{

  group('Login Test', () {
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

    test('Try to login without email & password', () async {
      await driver.tap(signinButtonClick);
      await Future.delayed(const Duration(seconds: 3), () {});
    });

    test('Try to login without email', () async {
      await driver.tap(signinPasswordField);
      await driver.enterText('1234567r');
      await driver.tap(signinButtonClick);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
    test('Try to login without password', () async {
      await driver.tap(signinEmailField);
      await driver.enterText('example@ishraak.com');
      await driver.tap(signinPasswordField);
      await driver.enterText('');
      await driver.tap(signinButtonClick);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
    test('Try to login with, which is actually not an email', () async {
      await driver.tap(signinEmailField);
      await driver.enterText('emailField');
      await driver.tap(signinPasswordField);
      await driver.enterText('1234567r');
      await driver.tap(signinButtonClick);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
    test('Try to login with wrong format of password, all numaric ', () async {
      await driver.tap(signinEmailField);
      await driver.enterText('example@ishraak.com');
      await driver.tap(signinPasswordField);
      await driver.enterText('0123456789');
      await driver.tap(signinButtonClick);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
    test('Try to login with wrong format of password, all alphabet ', () async {
      await driver.tap(signinEmailField);
      await driver.enterText('example@ishraak.com');
      await driver.tap(signinPasswordField);
      await driver.enterText('abcdefghijkl');
      await driver.tap(signinButtonClick);
      await Future.delayed(const Duration(seconds: 3), () {});
    });

    test('Try to login with unregistered email and password', () async {
      await driver.tap(signinEmailField);
      await driver.enterText('unregistered@ishraak.com');
      await driver.tap(signinPasswordField);
      await driver.enterText('1234567r');
      await driver.tap(signinButtonClick);
      await Future.delayed(const Duration(seconds: 3), () {});
    });

    test('Check Forgot Password link is working', () async {
      await driver.tap(forgotPasswordLink);
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(backButton);
    });

    /* test('Check SignUp button is working', () async {
      await driver.tap(signUpButton);
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Go back to the sign in page after checking the signup link', () async {
      await driver.tap(findSigninButtonfromSignup);
      await Future.delayed(const Duration(seconds: 2), (){});
    });*/

    /*test('Try to login with registered email and password', () async {
      await driver.tap(signinEmailField);
      await driver.enterText('mahmudoni01@gmail.com');
      await driver.tap(signinPasswordField);
      await driver.enterText('1234567r');
      await driver.tap(signinButtonClick);
      await Future.delayed(const Duration(seconds: 3), () {});
    });*/

   /* test('Skipping the Onboarding screan and wait for dashboard', () async {
      await driver.tap(skipOnboardingScreen);
      await Future.delayed(const Duration(seconds: 6), () {});
    });*/


  });

  //dashboardTest();
}

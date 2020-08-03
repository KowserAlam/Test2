import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


void main() {

  group('Login Test', () {

    final emailField = find.byValueKey('signInEmail');
    final passwordField = find.byValueKey('signInPassword');
    final buttonClick = find.byValueKey('signInButton');
    final forgotPasswordLink = find.text('Forgot Password ?');
    final backButton = find.byTooltip('Back');
    final signUpButton = find.byValueKey('signUpButton');
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

    test('Try to login without email & password', () async {
      await driver.tap(buttonClick);
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Try to login without email', () async {
      await driver.tap(passwordField);
      await driver.enterText('1234567r');
      await driver.tap(buttonClick);
      await Future.delayed(const Duration(seconds: 2), (){});
    });
    test('Try to login without password', () async {
      await driver.tap(emailField);
      await driver.enterText('example@ishraak.com');
      await driver.tap(passwordField);
      await driver.enterText('');
      await driver.tap(buttonClick);
      await Future.delayed(const Duration(seconds: 2), (){});

    });
    test('Try to login with, which is actually not an email', () async {
      await driver.tap(emailField);
      await driver.enterText('emailField');
      await driver.tap(passwordField);
      await driver.enterText('1234567r');
      await driver.tap(buttonClick);
      await Future.delayed(const Duration(seconds: 2), (){});
    });
    test('Try to login with wrong format of password, all numaric ', () async {
      await driver.tap(emailField);
      await driver.enterText('example@ishraak.com');
      await driver.tap(passwordField);
      await driver.enterText('0123456789');
      await driver.tap(buttonClick);
      await Future.delayed(const Duration(seconds: 2), (){});
    });
    test('Try to login with wrong format of password, all alphabet ', () async {
      await driver.tap(emailField);
      await driver.enterText('example@ishraak.com');
      await driver.tap(passwordField);
      await driver.enterText('abcdefghijkl');
      await driver.tap(buttonClick);
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Try to login with unregistered email and password', () async {

      await driver.tap(emailField);
      await driver.enterText('unregistered@ishraak.com');
      await driver.tap(passwordField);
      await driver.enterText('1234567r');
      await driver.tap(buttonClick);
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Check Forgot Password link is working', () async {
      await driver.tap(forgotPasswordLink);
      await Future.delayed(const Duration(seconds: 2), (){});
      await driver.tap(backButton);
    });

    test('Try to login with registered email and password', () async {

      await driver.tap(emailField);
      await driver.enterText('mahmudoni01@gmail.com');
      await driver.tap(passwordField);
      await driver.enterText('1234567r');
      await driver.tap(buttonClick);
      await Future.delayed(const Duration(seconds: 2), (){});
    });


  });


}

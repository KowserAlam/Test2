import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


main(){
  signUpTest();
}
Future<void> signUpTest()async{
  group('Signup Test', () {

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
    test('Click on signup button on login screen', () async {
      await driver.tap(Keys.signUpText);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(Keys.signUpTextTitleOnSignUpScreen), 'Sign Up');
    });
    test('Click on signup button when all fields are empty', () async {
      await driver.tap(Keys.signUpRegisterButton);
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Try to signup with wrong email format', () async {
      await driver.tap(Keys.signUpNameField);
      await driver.enterText('Name');
      await driver.tap(Keys.signUpEmailField);
      await driver.enterText('wrong email');
      await driver.tap(Keys.signUpMobileField);
      await driver.enterText('01724232886');
      await driver.tap(Keys.signUpPasswordField);
      await driver.enterText('1234567s');
      await driver.tap(Keys.signUpRegisterButton);
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Try to signup with wrong mobile format', () async {
      await driver.tap(Keys.signUpNameField);
      await driver.enterText('Name');
      await driver.tap(Keys.signUpEmailField);
      await driver.enterText('email@email.com');
      await driver.tap(Keys.signUpMobileField);
      await driver.enterText('017242328866');
      await driver.tap(Keys.signUpPasswordField);
      await driver.enterText('1234567s');
      await driver.tap(Keys.signUpRegisterButton);
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Try to signup with wrong password format all numeric', () async {
      await driver.tap(Keys.signUpNameField);
      await driver.enterText('Name');
      await driver.tap(Keys.signUpEmailField);
      await driver.enterText('email@email.com');
      await driver.tap(Keys.signUpMobileField);
      await driver.enterText('01724232886');
      await driver.tap(Keys.signUpPasswordField);
      await driver.enterText('12345678');
      await driver.tap(Keys.signUpRegisterButton);
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Try to signup with wrong password format all alphabet', () async {
      await driver.tap(Keys.signUpNameField);
      await driver.enterText('Name');
      await driver.tap(Keys.signUpEmailField);
      await driver.enterText('email@email.com');
      await driver.tap(Keys.signUpMobileField);
      await driver.enterText('01724232886');
      await driver.tap(Keys.signUpPasswordField);
      await driver.enterText('abcdefgh');
      await driver.tap(Keys.signUpRegisterButton);
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Try to signup with wrong password format less than 8 characters', () async {
      await driver.tap(Keys.signUpNameField);
      await driver.enterText('Name');
      await driver.tap(Keys.signUpEmailField);
      await driver.enterText('email@email.com');
      await driver.tap(Keys.signUpMobileField);
      await driver.enterText('01724232886');
      await driver.tap(Keys.signUpPasswordField);
      await driver.enterText('123456s');
      await driver.tap(Keys.signUpRegisterButton);
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Sign up using existing email and check replay', () async {
      await driver.tap(Keys.signUpNameField);
      await driver.enterText('Name');
      await driver.tap(Keys.signUpEmailField);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(Keys.signUpMobileField);
      await driver.enterText('01724232886');
      await driver.tap(Keys.signUpPasswordField);
      await driver.enterText('1234567s');
      await driver.tap(Keys.signUpRegisterButton);
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Sign up using proper information', () async {
      await driver.tap(Keys.signUpNameField);
      await driver.enterText('Name');
      await driver.tap(Keys.signUpEmailField);
      await driver.enterText('email@email.com');
      await driver.tap(Keys.signUpMobileField);
      await driver.enterText('01724232886');
      await driver.tap(Keys.signUpPasswordField);
      await driver.enterText('1234567s');
      await driver.tap(Keys.signUpRegisterButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await driver.tap(find.text('OK'));
      //
    });

  });
  //loginTest();

}

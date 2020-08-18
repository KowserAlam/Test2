import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import '../keys.dart';



main(){
  contactUSTest();
}
Future<void> contactUSTest()async{

  group('Contact Us Test :', () {

    final dashBoardContactUsTile = find.byValueKey('dashBoardContactUsTile');
    final dashBoardListview = find.byValueKey('dashBoardListview');


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
      await driver.tap(Keys.signInEmail);
      await driver.enterText('mahmudoni01@gmail.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), () {});
    });

    /*test('Click on Dashboard from bottom navigation bar', () async {
      await driver.tap(Keys.bottomNavigationBarDashboard);
      await Future.delayed(const Duration(seconds: 10), () {});
    });*/

    test('Click on contact us tile', () async {
      await driver.scrollUntilVisible(dashBoardListview, dashBoardContactUsTile,
          dyScroll: -600);
      await driver.tap(dashBoardContactUsTile);
      await driver.tap(Keys.backButton);
    });

    test('Click on Submit button while all the text boxes are empty', () async {
      await driver.tap(Keys.tapOnSubmitButton);
    });

    test('Try to submit while name textfield is empty', () async {
      await driver.tap(Keys.tapOnNameField);
      await driver.enterText('');
      await driver.tap(Keys.tapOnEmailField);
      await driver.enterText('example@ishraak.com');
      await driver.tap(Keys.tapOnPhoneField);
      await driver.enterText('01700000000');
      await driver.tap(Keys.tapOnSubjectField);
      await driver.enterText('Sample Email Subject');
      await driver.tap(Keys.tapOnMessageField);
      await driver.enterText('Sample message text for test the message field on test automation');
      await driver.tap(Keys.tapOnSubmitButton);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
    test('Try to submit while email textfield is empty', () async {
      await driver.tap(Keys.tapOnNameField);
      await driver.enterText('Ishraak');
      await driver.tap(Keys.tapOnEmailField);
      await driver.enterText('');
      await driver.tap(Keys.tapOnPhoneField);
      await driver.enterText('01700000000');
      await driver.tap(Keys.tapOnSubjectField);
      await driver.enterText('Sample Email Subject');
      await driver.tap(Keys.tapOnMessageField);
      await driver.enterText('Sample message text for test the message field on test automation');
      await driver.tap(Keys.tapOnSubmitButton);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
    test('Try to submit while phone textfield is empty', () async {
      await driver.tap(Keys.tapOnNameField);
      await driver.enterText('Ishraak');
      await driver.tap(Keys.tapOnEmailField);
      await driver.enterText('example@ishraak.com');
      await driver.tap(Keys.tapOnPhoneField);
      await driver.enterText('');
      await driver.tap(Keys.tapOnSubjectField);
      await driver.enterText('Sample Email Subject');
      await driver.tap(Keys.tapOnMessageField);
      await driver.enterText('Sample message text for test the message field on test automation');
      await driver.tap(Keys.tapOnSubmitButton);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
  });

}
//flutter drive --flavor dev --target=test_driver/other_pages/contactus.dart

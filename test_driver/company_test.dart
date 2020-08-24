import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'keys.dart';



main(){
  company();
}

Future<void> company() async{
  return group('Company :', () {
    final companySearchToggleButtonKey = find.byValueKey('companySearchToggleButtonKey');
    final companySearchInputTextFieldKey = find.byValueKey('companySearchInputTextFieldKey');
    final companySearchButtonKey = find.byValueKey('companySearchButtonKey');
    final companyListTileKey9 = find.byValueKey('companyListTileKey9');
    final companyListView = find.byValueKey('companyListView');


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

    test('login with registered email and password', () async {
      await driver.tap(Keys.signInEmail);
      await driver.enterText('mahmudoni01@gmail.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), () {});
    });

    test('Go to company screen from dashboard', () async{
      await driver.tap(Keys.bottomNavigationBarCompany);
      await Future.delayed(const Duration(seconds: 5), () {});

    });

    test('Check job details is showing - tile 1', () async {
      await driver.tap(Keys.companyListTileKey0); //to see job details is working
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(Keys.backButton);
    });

    test('Check job details is showing - tile 2', () async {
      await driver.tap(Keys.companyListTileKey1); //to see job details is working
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(Keys.backButton);
    });

    test('Check toggle Search button is working', () async {
      await driver.tap(companySearchToggleButtonKey);
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(companySearchToggleButtonKey);
      await Future.delayed(const Duration(seconds: 3), () {});
    });

    test('Check Random input search is working', () async {
      await driver.tap(companySearchToggleButtonKey);
      await driver.enterText('randomText');
      await driver.tap(companySearchButtonKey);
      await Future.delayed(const Duration(seconds: 5), () {});
    });

    test('Check ishraak input search is working', () async {
      await driver.tap(companySearchInputTextFieldKey);
      await driver.enterText('ishraak');
      await driver.tap(companySearchButtonKey);
      await Future.delayed(const Duration(seconds: 5), () {});
      await driver.tap(Keys.companyListTileKey0);
      await driver.tap(Keys.backButton);
    });

    test('Check ISH input search is working', () async {
      await driver.tap(companySearchInputTextFieldKey);
      await driver.enterText('ISH');
      await driver.tap(companySearchButtonKey);
      await Future.delayed(const Duration(seconds: 5), () {});
      await driver.tap(Keys.companyListTileKey0);
      await driver.tap(Keys.backButton);
      await driver.tap(companySearchToggleButtonKey);
      await Future.delayed(const Duration(seconds: 6), () {});
    });

    test('Check pagination is working', () async {
      await driver.scrollUntilVisible(companyListView, companyListTileKey9,
          dyScroll: -600);
      await driver.tap(companyListTileKey9); //to see pagination is working
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(Keys.backButton);
    });



  });

}

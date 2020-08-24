import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import '../keys.dart';
import 'keys.dart';



main(){
  company();
}

Future<void> company() async{
  return group('Company :', () {
    final companySearchToggleButtonKey = find.byValueKey('companySearchToggleButtonKey');
    final companySearchInputTextFieldKey = find.byValueKey('companySearchInputTextFieldKey');
    final companySearchButtonKey = find.byValueKey('companySearchButtonKey');


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

    test('Check toggle Search button is working', () async {
      await driver.tap(companySearchToggleButtonKey);
      await Future.delayed(const Duration(seconds: 5), () {});
      await driver.tap(companySearchToggleButtonKey);
      await Future.delayed(const Duration(seconds: 5), () {});
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
    });

    test('Check ISH input search is working', () async {
      await driver.tap(companySearchInputTextFieldKey);
      await driver.enterText('ISH');
      await driver.tap(companySearchButtonKey);
      await Future.delayed(const Duration(seconds: 5), () {});
    });
    test('Check job details is working after job search', () async {
      await driver
          .tap(Keys.clickOnFirstTileOnAllJobs); //to see job details is working
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(Keys.backButton);
    });


  });

}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import '../keys.dart';



main(){
  contactUSTest();
}
Future<void> contactUSTest()async{

  group('Contact Us Test :', () {

    final dashBoardContactUsTile = find.byValueKey('dashBoardContactUsTile');
    final dashBoardFAQTile = find.byValueKey('dashBoardFAQTile');
    final dashBoardAboutUsTile = find.byValueKey('dashBoardAboutUsTile');
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
    test('Click on Dashboard from bottom navigation bar', () async {
      await driver.tap(Keys.bottomNavigationBarDashboard);
      await Future.delayed(const Duration(seconds: 10), () {});
    });

    test('Click on contact us tile', () async {
      await driver.scrollUntilVisible(dashBoardListview, dashBoardContactUsTile,
          dyScroll: -600);
      await driver.tap(dashBoardContactUsTile);
      await driver.tap(Keys.backButton);
    });

  });

}
//flutter drive --flavor dev --target=test_driver/other_pages/contactus.dart

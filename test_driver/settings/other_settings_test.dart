import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


//flutter drive --flavor dev --target=test_driver/settings/other_settings.dart

main(){
  otherSettings();
}
Future<void> otherSettings()async{
  group('Other Settings Test: ', () {


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
    test('Getting to My Profile screen', () async {
      await driver.tap(Keys.bottomNavigationBarMyProfile);
      await Future.delayed(const Duration(seconds: 5), (){});
    });




  });

}

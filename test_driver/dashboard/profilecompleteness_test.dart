//profileProfileCompletePercentIndicatorWidget
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


main(){
  profileCompletenessBar();
}
Future<void> profileCompletenessBar()async{

  group('Profile Completeness Bar', () {

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


  });

}

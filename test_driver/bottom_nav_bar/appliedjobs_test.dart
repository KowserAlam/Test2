import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


main(){
  appliedJobsTest();
}
Future<void> appliedJobsTest()async{

  group('Applied Jobs Test', () {
    final clickOnAppliedJobsFromSegmentScreen = find.text('Applied');
    //final clickOnAppliedJobsFromSegmentScreen = find.bySemanticsLabel(StringResources.favoriteText);
    //final clickOnAppliedJobsFromSegmentScreen = find.bySemanticsLabel(StringResources.allText);

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

    test('Click on Applied Jobs on jobs Screen segment control bar', () async {
      await driver.tap(clickOnAppliedJobsFromSegmentScreen);
      await Future.delayed(const Duration(seconds: 2), () {});
    });

  });

}

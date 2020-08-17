import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import '../keys.dart';

main(){
  favoriteJobsTest();
}
Future<void> favoriteJobsTest()async{

  group('Favorite Jobs Test :', () {

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

    //remove comment when it needs to be run individually
    /*test('login with registered email and password', () async {
      await driver.tap(keys.signInEmail);
      await driver.enterText('mahmudoni01@gmail.com');
      await driver.tap(keys.signInPassword);
      await driver.enterText('1234567r');
      await driver.tap(keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), () {});
    });*/
    /*test('Click on Jobs from bottom navigation bar', () async {
      await driver.tap(keys.bottomNavigationBarJobs);
      await Future.delayed(const Duration(seconds: 10), () {});
    });*/

    test('Go to Favorited Jobs list on jobs Screen segment control bar', () async {
      await driver.tap(keys.clickOnFavoriteJobsFromSegmentScreen);
      await Future.delayed(const Duration(seconds: 5), () {});
    });

    //showing job details
    test('Check if job details are showing from favorite job list', () async {
      await driver.tap(keys.clickOnFirstTileOnFavoriteJobs); //to see job details is working from applied job list
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(keys.backButton);
    });

    test('Check Unuavorite is working', () async {
      await driver.tap(keys.checkFavoriteUnfavoriteFromFavoriteList);
      await Future.delayed(const Duration(seconds: 4), () {});
    });

    test('Check Favorite is working', () async {
      await driver.tap(keys.checkFavoriteUnfavoriteFromFavoriteList);
      await Future.delayed(const Duration(seconds: 4), () {});

    });

  });

}
//flutter drive --flavor dev --target=test_driver/jobs_segment/favoritejobs.dart

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import '../keys.dart';
import 'alljobs_test.dart';


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
     /* test('login with registered email and password', () async {
      await driver.tap(Keys.signInEmail);
      await driver.enterText('mahmudoni01@gmail.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
      test('Click on Jobs from bottom navigation bar', () async {
      await driver.tap(Keys.bottomNavigationBarJobs);
      await Future.delayed(const Duration(seconds: 10), () {});
    });
*/
    test('Go to Favorited Jobs list on jobs Screen segment control bar', () async {
      await driver.tap(Keys.clickOnFavoriteJobsFromSegmentScreen);
      await Future.delayed(const Duration(seconds: 5), () {});
    });

    //showing job details
    test('Check if job details are showing from favorite job list', () async {
      await driver.tap(Keys.clickOnFirstTileOnFavoriteJobs); //to see job details is working from applied job list
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(Keys.backButton);
    });

    test('Click on apply button on favorite jobs', () async{
      await driver.tap(Keys.clickOnFirstApplyKeyOnFavoriteJobs);
      await Future.delayed(const Duration(seconds: 5), () {});
      await driver.tap(Keys.dialogBoxNoButton);
     });

    /*test('Check Unuavorite is working', () async {
      await driver.tap(Keys.checkFavoriteUnfavoriteFromFavoriteList);
      await Future.delayed(const Duration(seconds: 4), () {});
    });

    test('Check Favorite is working', () async {
      await driver.tap(Keys.checkFavoriteUnfavoriteFromFavoriteList);
      await Future.delayed(const Duration(seconds: 4), () {});

    });*/

  });
  allJobsTest();
}
//flutter drive --flavor dev --target=test_driver/jobs_segment/favoritejobs.dart

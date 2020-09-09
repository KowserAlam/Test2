import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';

main(){
  myProfilePortfolioTest();
}
Future<void> myProfilePortfolioTest()async{
  group('My Profile - Professional Portfolio Test', () {

    //flutter drive --flavor dev --target=test_driver/my_profile/my_profile_portfolio.dart

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
    test('Getting to Portfolio Add screen', () async {
      await driver.scrollUntilVisible(Keys.myProfileScrollView, Keys.myProfilePortfolioPenKey, dyScroll: -50);
      await driver.tap(Keys.myProfilePortfolioPenKey);
      await driver.tap(Keys.myProfilePortfolioAddKey);
      await expect(await driver.getText(Keys.portfolioAppbarTitle), 'Portfolio');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Try to save while all fields are empty', () async {
      await driver.tap(Keys.portfolioSaveButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(Keys.portfolioAppbarTitle), 'Portfolio');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Insert Title and save', () async {
      await driver.tap(Keys.portfolioName);
      await driver.enterText('Test Title');
      await driver.tap(Keys.portfolioSaveButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Add a second entry to check delete later', () async {
      await driver.tap(Keys.myProfilePortfolioAddKey);
      await driver.tap(Keys.portfolioName);
      await driver.enterText('Test Title 2');
      await driver.tap(Keys.portfolioSaveButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check if edit is working & save with a description', () async {
      await driver.tap(Keys.portfolioTileEditButton);
      await driver.tap(Keys.portfolioName);
      await driver.enterText('Test Title Edited');
      await driver.tap(Keys.portfolioDescription);
      await driver.enterText('Test Description');
      await driver.tap(Keys.portfolioSaveButton);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(Keys.myProfileAppbarTitle), 'My Profile');
      await expect(await driver.getText(Keys.portfolioTileName), 'Test Title Edited');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check if delete is working', () async {
      await driver.tap(Keys.portfolioTileDeleteButton);
      await driver.tap(Keys.commonPromptYes);
      await expect(await driver.getText(Keys.portfolioTileName), 'Test Title 2');
      await Future.delayed(const Duration(seconds: 5), (){});
    });


  });

}

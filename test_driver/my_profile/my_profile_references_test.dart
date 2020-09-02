import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


//flutter drive --flavor dev --target=test_driver/my_profile/my_profile_references.dart

main(){
  myProfileReferencesTest();
}
Future<void> myProfileReferencesTest()async{
  group('My Profile - References Test', () {


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
    test('Check add button is working', () async {
      await driver.scrollUntilVisible(Keys.myProfileScrollView, Keys.myProfileAddReferencesPen, dyScroll: -200);
      await driver.tap(Keys.myProfileAddReferencesPen);
      await driver.tap(Keys.myProfileAddReferencesAdd);
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Try to save while all fields are empty', () async {
      await driver.tap(Keys.myProfileReferencesSaveButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await expect(await driver.getText(Keys.referencesAppbarTitle), 'Reference');
    });

    test('Check if description can be saved', () async {
      await driver.tap(Keys.referencesDescription);
      await driver.enterText('Test Description');
      await driver.tap(Keys.myProfileReferencesSaveButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await expect(await driver.getText(Keys.referenceTileDescription1), 'Test Description');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Adding a second entry to check delete key later', () async {
      await driver.tap(Keys.myProfileAddReferencesAdd);
      await driver.tap(Keys.referencesDescription);
      await driver.enterText('Second Test Description');
      await driver.tap(Keys.myProfileReferencesSaveButton);
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check edit button working and can be updated', () async {
      await driver.tap(Keys.myProfileReferencesTileEditButton1);
      await driver.tap(Keys.referencesDescription);
      await driver.enterText('Edited Test Description');
      await driver.tap(Keys.myProfileReferencesSaveButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await expect(await driver.getText(Keys.referenceTileDescription1), 'Edited Test Description');
      //await expect(await driver.getText(keys.myProfileAppbarTitle), 'My Profile');
    });

    test('Check delete button is working with confirmation popup', () async {
      await driver.tap(Keys.myProfileReferencesTileDeleteButton1);
      await Future.delayed(const Duration(seconds: 5), (){});
      await driver.tap(Keys.commonPromptYes);
      await Future.delayed(const Duration(seconds: 10), (){});
      await expect(await driver.getText(Keys.referenceTileDescription1), 'Second Test Description');
    });

  });

}

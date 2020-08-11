import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


//flutter drive --flavor dev --target=test_driver/my_profile/my_profile_references.dart

void main() {
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
    test('Getting to My Profile screen', () async {
      await driver.tap(keys.signInEmail);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(keys.signInPassword);
      await driver.enterText('1234567s');
      await driver.tap(keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await driver.tap(keys.onboardingPageSkipButton);
      await Future.delayed(const Duration(seconds: 5), (){});
      await driver.tap(keys.bottomNavigationBarMyProfile);
      await Future.delayed(const Duration(seconds: 10), (){});
    });

    test('Check add button is working', () async {
      await driver.scrollUntilVisible(keys.myProfileScrollView, keys.myProfileAddReferencesPen, dyScroll: -200);
      await driver.tap(keys.myProfileAddReferencesPen);
      await driver.tap(keys.myProfileAddReferencesAdd);
      await Future.delayed(const Duration(seconds: 10), (){});
    });

    test('Try to save while all fields are empty', () async {
      await driver.tap(keys.myProfileReferencesSaveButton);
      await Future.delayed(const Duration(seconds: 10), (){});
    });

    test('Check if description can be saved', () async {
      await driver.tap(keys.referencesDescription);
      await driver.enterText('Test Description');
      await driver.tap(keys.myProfileReferencesSaveButton);
      await Future.delayed(const Duration(seconds: 10), (){});
    });

//    test('Check if description can be saved', () async {
//      await driver.tap(keys.referencesDescription);
//      await driver.enterText('Test Description');
//      await driver.tap(keys.myProfileReferencesSaveButton);
//      await Future.delayed(const Duration(seconds: 10), (){});
//    });

  });

}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';

main(){
  filterTest();
}
Future<void> filterTest()async{

  group('Filter Test :', () {

    final filterButtonKey = find.byValueKey('filterButtonKey');
    final filterCloseButtonKey = find.byValueKey('filterCloseButtonKey');
    final filterClearAllButtonKey = find.byValueKey('filterClearAllButtonKey');
    final filterListViewKey = find.byValueKey('filterListViewKey');
    final filterSortByTextfieldKey = find.byValueKey('filterSortByTextfieldKey');
    final filterJobCategoryTextfieldKey = find.byValueKey('filterJobCategoryTextfieldKey');
    final filterLocationTextfieldKey = find.byValueKey('filterLocationTextfieldKey');
    final filterSkillTextfieldKey = find.byValueKey('filterSkillTextfieldKey');
    final filterJobTypeTextfieldKey = find.byValueKey('filterJobTypeTextfieldKey');
    final filterQualificationTextfieldKey = find.byValueKey('filterQualificationTextfieldKey');
    final filterGenderTextfieldKey = find.byValueKey('filterGenderTextfieldKey');
    final filterDatePostedTextfieldKey = find.byValueKey('filterDatePostedTextfieldKey');
    final applyFilterButtonKey = find.byValueKey('applyFilterButtonKey');

    final findTextKhulna = find.text('Khulna');

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
    test('login with registered email and password', () async {
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

    test('Open & close filter section', () async {
      await driver.tap(filterButtonKey);
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(filterCloseButtonKey);
    });

    test('Open filter section and search location', () async {
      await driver.tap(filterButtonKey);
      await driver.tap(filterLocationTextfieldKey);
      await driver.enterText('Khulna');
      await driver.scrollUntilVisible(filterListViewKey, applyFilterButtonKey,
          dyScroll: -600);
      await driver.tap(applyFilterButtonKey);
      await Future.delayed(const Duration(seconds: 6), () {});
      //expect(find.text('Khulna'), findTextKhulna);
      //await expect(await driver.getText(findTextKhulna), 'Khulna');
      //await Future.delayed(const Duration(seconds: 6), () {});
    });

  });

}
//flutter drive --flavor dev --target=test_driver/jobs_segment/filter.dart

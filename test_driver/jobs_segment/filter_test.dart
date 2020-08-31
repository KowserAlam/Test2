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
    final salaryRangeKey = find.byValueKey('salaryRangeKey');

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
      await expect(await driver.getText(Keys.jobsAppbarTitle), 'Jobs');
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
      await driver.tap(applyFilterButtonKey);
      await Future.delayed(const Duration(seconds: 8), () {});
    });

    test('Open filter section and search Category', () async {
      await driver.tap(filterButtonKey);
      await driver.tap(filterClearAllButtonKey);
      await driver.tap(filterJobCategoryTextfieldKey);
      await driver.enterText('Back-End Develop');
      await driver.tap(find.text('Back-End Developer'));
      await driver.tap(applyFilterButtonKey);
      await Future.delayed(const Duration(seconds: 8), () {});
    });

    test('Open filter section and search Sort By - Top Rated', () async {
      await driver.tap(filterButtonKey);
      await driver.tap(filterClearAllButtonKey);
      await driver.tap(filterSortByTextfieldKey);
      await driver.tap(find.text('Top Rated'));
      await driver.tap(applyFilterButtonKey);
      await Future.delayed(const Duration(seconds: 8), () {});
    });

    test('Open filter section and search Sort By - Most Recent', () async {
      await driver.tap(filterButtonKey);
      await driver.tap(filterClearAllButtonKey);
      await driver.tap(filterSortByTextfieldKey);
      await driver.tap(find.text('Most Recent'));
      await driver.tap(applyFilterButtonKey);
      await Future.delayed(const Duration(seconds: 8), () {});
    });

    test('Open filter section and search Skill', () async {
      await driver.tap(filterButtonKey);
      await driver.tap(filterClearAllButtonKey);
      await driver.tap(filterSkillTextfieldKey);
      await driver.enterText('Pytho');
      await driver.tap(find.text('Python'));
      await driver.tap(applyFilterButtonKey);
      await Future.delayed(const Duration(seconds: 8), () {});
    });

    test('Open filter section and search Job Type', () async {
      await driver.tap(filterButtonKey);
      await driver.tap(filterClearAllButtonKey);
      await driver.tap(filterJobTypeTextfieldKey);
      await driver.tap(find.text('Permanent'));
      await driver.tap(applyFilterButtonKey);
      await Future.delayed(const Duration(seconds: 8), () {});
    });

    test('Open filter section and search Qualification', () async {
      await driver.tap(filterButtonKey);
      await driver.tap(filterClearAllButtonKey);
      await driver.scrollUntilVisible(filterListViewKey, filterQualificationTextfieldKey,
          dyScroll: -150);
      await driver.tap(filterQualificationTextfieldKey);
      await driver.tap(find.text('BSc in CSE'));
      await driver.tap(applyFilterButtonKey);
      await Future.delayed(const Duration(seconds: 8), () {});
    });

    test('Open filter section and search Gender', () async {
      await driver.tap(filterButtonKey);
      await driver.tap(filterClearAllButtonKey);
      await driver.scrollUntilVisible(filterListViewKey, filterGenderTextfieldKey,
          dyScroll: -150);
      await driver.tap(filterGenderTextfieldKey);
      await driver.tap(find.text('Male'));
      await driver.tap(applyFilterButtonKey);
      await Future.delayed(const Duration(seconds: 6), () {});
    });

    test('Open filter section and search Date Posted', () async {
      await driver.tap(filterButtonKey);
      await driver.tap(filterClearAllButtonKey);
      await driver.scrollUntilVisible(filterListViewKey, filterDatePostedTextfieldKey,
          dyScroll: -150);
      await driver.tap(filterDatePostedTextfieldKey);
      await driver.tap(find.text('Last 7 days'));
      await driver.tap(applyFilterButtonKey);
      await Future.delayed(const Duration(seconds: 6), () {});
    });

    test('Open filter section and search while all fields are filled', () async {
      await driver.tap(filterButtonKey);
      await driver.tap(filterClearAllButtonKey);
      await driver.tap(filterJobCategoryTextfieldKey);
      await driver.enterText('Back-End Develop');
      await driver.tap(find.text('Back-End Developer'));
      await driver.tap(filterLocationTextfieldKey);
      await driver.enterText('Khulna');
      await driver.tap(filterSkillTextfieldKey);
      await driver.enterText('Pytho');
      await driver.tap(find.text('Python'));
      await driver.tap(filterJobTypeTextfieldKey);
      await driver.tap(find.text('Permanent'));
      await driver.scrollUntilVisible(filterListViewKey, filterQualificationTextfieldKey,
          dyScroll: -150);
      await driver.tap(filterQualificationTextfieldKey);
      await driver.tap(find.text('BSc in CSE'));
      await driver.scrollUntilVisible(filterListViewKey, filterGenderTextfieldKey,
          dyScroll: -150);
      await driver.tap(filterGenderTextfieldKey);
      await driver.tap(find.text('Male'));
      await driver.scrollUntilVisible(filterListViewKey, filterGenderTextfieldKey,
          dyScroll: -150);
      await driver.tap(filterDatePostedTextfieldKey);
      await driver.tap(find.text('Last 30 days'));
      await driver.tap(applyFilterButtonKey);
      await Future.delayed(const Duration(seconds: 10), () {});
    });

    test('Open filter section and search Gender', () async {
      await driver.tap(filterButtonKey);
      await driver.tap(filterClearAllButtonKey);
      await driver.scrollUntilVisible(filterListViewKey, salaryRangeKey,
          dyScroll: -150);
      await driver.tap(salaryRangeKey);
      await driver.tap(applyFilterButtonKey);
      await Future.delayed(const Duration(seconds: 6), () {});
    });
    //salaryRangeKey

    //experienceRangeKey



    //setState(() => value = something);

    //MyWidget testWidget = MyWidget() then await tester.pumpWidget(testWidget);.
    // Now you can call testWidget.setState();
  });

}
//flutter drive --flavor dev --target=test_driver/jobs_segment/filter.dart

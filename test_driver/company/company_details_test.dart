import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';

//flutter drive --flavor dev --target=test_driver/company/company_details.dart


main() {
  jobDetailsTest();
}

Future<void> jobDetailsTest() async {
  String jobTitle ,jobCompanyName;

  group('Company Details & Open Jobs Test Cases: ', () {

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
    test('Getting to Dashboard', () async {
      await driver.tap(Keys.signInEmail);
      await driver.enterText('kowser@ishraak.com');
      await driver.tap(Keys.signInPassword);
      await driver.enterText('1234567s');
      await driver.tap(Keys.signInButton);
      await Future.delayed(const Duration(seconds: 3), (){});
      await driver.tap(Keys.bottomNavigationBarCompany);
      await expect(await driver.getText(Keys.companyListAppbarTitle), 'Companies');
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Getting to Company Detail screen', () async {
      await driver.tap(Keys.companyListTileKey0);
      await expect(await driver.getText(Keys.companyDetailsAppbarTitle), 'Company Details');
      print('1');
      await expect(await driver.getText(Keys.companyDetailsCompanyName), '000000');
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Check Open jobs are showing if have', () async {
      await driver.scrollUntilVisible(Keys.companyDetailsListViewKey, Keys.companyDetailsOpenJobsKey0, dyScroll: -200);
      await driver.tap(Keys.companyDetailsOpenJobsKey0);
      await expect(await driver.getText(Keys.jobDetailsJobTitle), 'Additional Test job 2');
      await driver.tap(Keys.backButton);
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Check if published date is showing', () async {
      await expect(await driver.getText(Keys.openJobsPublishedDate0), '05/09/2020');
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Check showing deadline if not found show none', () async {
      await expect(await driver.getText(Keys.openJobsDeadline0), 'none');
      await expect(await driver.getText(Keys.openJobsDeadline1), '30/08/2020');
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Check showing deadline if not found show none', () async {
      await expect(await driver.getText(Keys.openJobsDeadline0), 'none');
      await expect(await driver.getText(Keys.openJobsDeadline1), '30/08/2020');
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Check showing company name', () async {
      await expect(await driver.getText(Keys.jobTileCompanyName), '000000');
      await Future.delayed(const Duration(seconds: 2), (){});
    });

    test('Check showing company location', () async {
      await expect(await driver.getText(Keys.openJobsCompanyLocation0), 'Dhaka, Bangladesh');
      await Future.delayed(const Duration(seconds: 2), (){});
    });


  });
}

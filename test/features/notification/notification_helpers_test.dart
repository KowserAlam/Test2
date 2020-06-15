import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/features/notification/notification_helpers.dart';

main() {
  group("calculateTimeStamp Test", () {
    test("Testing with 1 hour difference , should return 1h", () {
      var val = NotificationHelper.calculateTimeStamp(
          DateTime.now().subtract(Duration(hours: 1)),
          compareWith: DateTime.now());
      expect(val, '1h');
    });

    test("Testing with 10 hour difference , should return 10h", () {
      var val = NotificationHelper.calculateTimeStamp(
          DateTime.now().subtract(Duration(hours: 10)),
          compareWith: DateTime.now());
      expect(val, '10h');
    });

    test("Testing with 1 day  difference , should return 1day", () {
      var val = NotificationHelper.calculateTimeStamp(
          DateTime.now().subtract(Duration(hours: 25)),
          compareWith: DateTime.now());
      expect(val, '1day');
    });
    test("Testing with 29 day  difference , should return 29day", () {
      var val = NotificationHelper.calculateTimeStamp(
          DateTime.now().subtract(Duration(hours: 24 * 29)),
          compareWith: DateTime.now());
      expect(val, '29day');
    });

    test("Testing with 31 day  difference , should return 29day", () {
      var val = NotificationHelper.calculateTimeStamp(
          DateTime.now().subtract(Duration(hours: 24*31)),
          compareWith: DateTime.now());
      expect(val, '1month');
    });

    test("Testing with 370 day  difference , should return 1y", () {
      var val = NotificationHelper.calculateTimeStamp(
          DateTime.now().subtract(Duration(days: 370)),
          compareWith: DateTime.now());
      expect(val, '1y');
    });

  });
}

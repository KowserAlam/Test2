import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/features/notification/notification_helpers.dart';

main() {
  group("calculateTimeStamp Test", () {
    test("Testing with 1 hour difference , should return 1 hour", () {
      var val = NotificationHelper.calculateTimeStamp(
          DateTime.now().subtract(Duration(hours: 1)),
          compareWith: DateTime.now());
      expect(val, '1 hour');
    });

    test("Testing with 10 hour difference , should return 10 hour", () {
      var val = NotificationHelper.calculateTimeStamp(
          DateTime.now().subtract(Duration(hours: 10)),
          compareWith: DateTime.now());
      expect(val, '10 hour');
    });



  });
}

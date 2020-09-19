import 'package:p7app/method_extension.dart';

class NotificationHelper {
  static String calculateTimeStamp(DateTime createdAt, {DateTime compareWith}) {
    if (createdAt == null) return '';
    DateTime time = compareWith ?? DateTime.now();
    var difference = time.difference(createdAt);
    if (difference < Duration(minutes: 1))
      return "${difference.inSeconds} second";
    else if (difference < Duration(hours: 1))
      return "${difference.inMinutes} minute";
    else if (difference < Duration(hours: 25))
      return "${difference.inHours} hour";
    else
      // (difference < Duration(days: 30))
      return createdAt.formatDateTimeJX;
    //   // return "${(difference.inHours / 24).round()}day";
    // else if (difference < Duration(days: 365))
    //   return "${(difference.inDays / 30).round()}month";
    // else
    //   return "${(difference.inDays / 365).round()}y";
  }
}

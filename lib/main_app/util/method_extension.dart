import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';

extension DateTimeExtension on DateTime {
  String get toYYYMMDDString {
    if (this != null)
      return DateFormatUtil.dateFormatYYYMMDD(this);
    else
      return null;
  }

  bool  isToday() {
    if (this != null) {
      var day = DateTime.now().day;
      var month = DateTime.now().month;
      var year = DateTime.now().year;
      return this.day == day && this.month == month && this.year == year;
    } else {
      return false;
    }
  }
}

extension StringExtenion on String {
  bool get isEmptyOrNull {
    if (this != null) {
      return this.isEmpty;
    } else
      return true;
  }

  bool get isNotEmptyOrNotNull {
    if (this != null) {
      return this.isNotEmpty;
    } else
      return false;
  }

  String get replaceAmpWith26 {
    if (this != null) {
      return this.replaceAll("%26", "&");
    } else
      return null;
  }
}

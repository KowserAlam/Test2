import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';

extension DateTimeExtension on DateTime {
  String get toYYYMMDDString {
    if (this != null)
      return DateFormatUtil.dateFormatYYYMMDD(this);
    else
      return null;
  }
}

extension StringExtenion on String {
  bool get isEmptyOrNull {
    if (this != null) {
      return this.isEmpty;
    } else
      return true;
  }

  bool get  isNotEmptyOrNotNull{
    if (this != null){
      return this.isNotEmpty;
    }
    else
      return false;
  }

  String get  replaceAmpWith26{
    if (this != null){
      return this.replaceAll("%26", "&");
    }
    else
      return null;
  }
}

import 'package:p7app/main_app/util/date_format_uitl.dart';

extension DateTimeExtension on DateTime{
  String get  toYYYMMDDString{
    if (this != null)
      return DateFormatUtil.dateFormatYYYMMDD(this);
    else
      return null;
  }
}

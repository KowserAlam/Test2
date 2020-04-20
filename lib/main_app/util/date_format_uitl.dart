
import 'package:intl/intl.dart';

class DateFormatUtil{

  static String dateFormatYYYMMDD(DateTime dateTime){
    return DateFormat('YYYY-MM-DD').format(dateTime);
  }

  String dateFormat1(DateTime dateTime){
    return DateFormat.yMMMd().format(dateTime);
  }
}

import 'package:intl/intl.dart';

class DateFormatUtil{

  static String dateFormatYYYMMDD(DateTime dateTime){
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  String dateFormat1(DateTime dateTime){
    return DateFormat.yMMMd().format(dateTime);
  }
}
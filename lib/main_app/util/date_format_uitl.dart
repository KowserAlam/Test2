
import 'package:intl/intl.dart';

class DateFormatUtil{

  String dateFormat1(DateTime dateTime){
    return DateFormat.yMMMd().format(dateTime);
  }
}
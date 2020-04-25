
import 'package:intl/intl.dart';
import 'package:synchronized/extension.dart';
import 'package:flutter/material.dart';

class DateFormatUtil{



  static String dateFormatYYYMMDD(DateTime dateTime){
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
  static String formatDate(DateTime dateTime){
    return DateFormat.yMMMd().format(dateTime);
  }
  String dateFormat1(DateTime dateTime){
    return DateFormat.yMMMd().format(dateTime);
  }

}




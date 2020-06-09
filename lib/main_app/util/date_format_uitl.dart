
import 'package:intl/intl.dart';
import 'package:synchronized/extension.dart';
import 'package:flutter/material.dart';

class DateFormatUtil{



  static String dateFormatYYYMMDD(DateTime dateTime){
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
  static String formatDate(DateTime dateTime){
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
  static String formatDateTime(DateTime dateTime){
    return DateFormat("dd/MM/yyyy  hh:mm aaa").format(dateTime);
  }
  String dateFormat1(DateTime dateTime){
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

}



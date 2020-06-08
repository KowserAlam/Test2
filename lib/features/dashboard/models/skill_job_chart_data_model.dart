import 'package:intl/intl.dart';

class SkillJobChartDataModel {
  String month;
  int total;
  int year;
//  DateTime dateTimeValue;
  Map<int, String> _monthsInYear = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December"
  };

  SkillJobChartDataModel({
    this.month,
    this.total,
    this.year,
  });

  SkillJobChartDataModel.fromJson(json) {
    try {
      month = "${_monthsInYear[json[1]]}, ${json[0]}";
      total = json[2];
      year = json[0];
//      dateTimeValue = _ DateTime.parse('${json[0]}-${json[1]?.toString()?.padLeft(2, '0')}-01');
    } catch (e) {
      print(e);
    }

    ;
  }
}

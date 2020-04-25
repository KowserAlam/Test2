import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';

class CommonDatePickerWidget extends StatelessWidget {
  final String label;
  final DateTime date;
  final Function(DateTime) onDateTimeChanged;
  final Function onTapDateClear;

  const CommonDatePickerWidget({
    @required this.label,
    @required this.date,
    @required this.onDateTimeChanged,
    this.onTapDateClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          label ?? "",
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            _showDatePicker(context);
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                    color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
                BoxShadow(
                    color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    date != null
                        ? DateFormatUtil.formatDate(date)
                        : StringUtils.chooseDateText,
                  ),
                  date != null
                      ? InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.close),
                          ),
                          onTap: onTapDateClear,
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showDatePicker(context) {
    var miniDate = DateTime.now().subtract(Duration(days: 360 * 100));
    var maxDate = DateTime.now().add(Duration(days: 360 * 10));

    onDateTimeChanged(DateTime.now());

    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1.3,
              child: Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: CupertinoTheme(
                        data: CupertinoThemeData(
                            brightness: Theme.of(context).brightness),
                        child: CupertinoDatePicker(
                          maximumDate: maxDate,
                          minimumDate: miniDate,
                          initialDateTime: date ?? DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (v){
                            if(v.year >= miniDate.year && v.year <= maxDate.year) {
                              onDateTimeChanged(v);
                            }
                          },
                        ),
                      ),
                    ),
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.done,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

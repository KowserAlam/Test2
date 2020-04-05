import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionTileWidgetForExam extends StatelessWidget {
  final String option;
  final int index;
  final bool isSelected;
  final bool isCheckBox;

  final Color selectedColor = Colors.green.withOpacity(0.2);

  TextStyle selectedTextStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle unSelectedTextStyle = TextStyle(fontSize: 18);

  OptionTileWidgetForExam({
    @required this.option,
    @required this.index,
    @required this.isSelected,
    @required this.isCheckBox,
  });

  @override
  Widget build(BuildContext context) {

    Color unSelectedColor = Theme.of(context).backgroundColor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: isSelected ? selectedColor : unSelectedColor,
            border: Border.all(
                width: 1.0,
                color: isSelected ? Colors.green[100] : Colors.grey[300])),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              isCheckBox ? checkBox(context) : radioButton(context),
              SizedBox(
                width: 8,
              ),

              Expanded(
                child: Html(data: "$option",
                  defaultTextStyle: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
            ],
          ),
        ),
        duration: Duration(milliseconds: 300),
      ),
    );
  }

  Widget checkBox(context) {
    return isSelected
        ? Icon(
            FontAwesomeIcons.solidCheckSquare,
            color: Theme.of(context).primaryColor,
          )
        : Icon(
            FontAwesomeIcons.square,
            color: Colors.grey,
          );
  }

  Widget radioButton(context) {
    return isSelected
        ? Icon(
            FontAwesomeIcons.dotCircle,
            color: Theme.of(context).primaryColor,
          )
        : Icon(
            FontAwesomeIcons.circle,
            color: Colors.grey,
          );
  }
}

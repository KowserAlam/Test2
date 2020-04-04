import 'package:p7app/main_app/util/comon_styles.dart';
import 'package:flutter/material.dart';

class SidebarIndicatorItem extends StatelessWidget {
  final String label;
  final Color color;
  final bool isCircle;

  SidebarIndicatorItem({this.label, this.color, this.isCircle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Row(
        children: <Widget>[
          isCircle != null
              ? Container(
                  padding: EdgeInsets.all(2),
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: color, width: 3)),
                )
              : Container(
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: color),
                ),
          SizedBox(
            width: 15,
          ),
          Text(
            label,
            style: kTitleTextBlackStyleSmall,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileCompletePercentIndicatorWidget extends StatelessWidget {
  final double percent;

  ProfileCompletePercentIndicatorWidget(this.percent);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${StringUtils.profileText.toUpperCase()}",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text("${(percent * 100).toInt()}%"),
              ],
            ),
          ),

          LinearPercentIndicator(
            lineHeight: 8.0,
            percent: percent,
            progressColor: Colors.blue,
            linearStrokeCap: LinearStrokeCap.butt,
          ),
        ],
      ),
    );
  }
}

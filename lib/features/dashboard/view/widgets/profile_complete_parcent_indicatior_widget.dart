import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileCompletePercentIndicatorWidget extends StatelessWidget {
  final double percent;

  ProfileCompletePercentIndicatorWidget(this.percent);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${StringResources.profileText.toUpperCase()}",
                  style: TextStyle(fontWeight: FontWeight.w500),
                  key: Key('profileProfileCompletePercentIndicatorWidget'),
                ),
                Text("${(percent * 100).toInt()}%"),
              ],
            ),
          ),

          LinearPercentIndicator(
            animation: true,
            lineHeight: 8.0,
            percent: percent,
            progressColor: Theme.of(context).primaryColor,
            linearStrokeCap: LinearStrokeCap.butt,
          ),
        ],
      ),
    );
  }
}

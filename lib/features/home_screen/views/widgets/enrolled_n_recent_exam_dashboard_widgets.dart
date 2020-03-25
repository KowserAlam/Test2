import 'package:assessment_ishraak/features/home_screen/views/widgets/recent_exam_dash_board_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'enrolled_exam_dashboard_widget.dart';

class EnrolledNRecentExamsDashBoardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLarge = MediaQuery.of(context).size.width > 720;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: isLarge
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              /// Tab view
              children: <Widget>[
                Expanded(
                  child: EnrolledExamListDashBoardWidget(),
                ),
                Expanded(
                  child: RecentExamDashBoardWidget(),
                ),
              ],
            )
          : Column(
              /// Mobile view
              children: <Widget>[
                EnrolledExamListDashBoardWidget(),
                SizedBox(height: 18,),
                RecentExamDashBoardWidget(),
              ],
            ),
    );
  }
}

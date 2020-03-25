import 'package:assessment_ishraak/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:assessment_ishraak/features/recent_exam/view/recent_exam_list_tile_widget.dart';
import 'package:assessment_ishraak/features/home_screen/views/widgets/view_more_button_widget.dart';
import 'package:assessment_ishraak/features/recent_exam/view/recent_exam_list_screen.dart';
import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:assessment_ishraak/main_app/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dash_board_widgets_place_holder_widgets.dart';

class RecentExamDashBoardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                StringUtils.recentExamsText,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Consumer<DashboardScreenProvider>(
                builder: (context, dashBoardScreenProvider, child) {
              if (dashBoardScreenProvider.dashBoardData != null) {
                if (dashBoardScreenProvider.dashBoardData.recentExam.length <=
                    3) {
                  return SizedBox();
                } else {
                  return ViewMoreButtonWidget(
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => RecentExamScreen()));
                    },
                  );
                }
              }
              return SizedBox();
            }),
          ],
        ),
        Consumer<DashboardScreenProvider>(
            builder: (context, dashboardScreenProvider, c) {
          if (dashboardScreenProvider.dashBoardData == null) {
            return DashBoardWidgetsPlaceHolderWidgets(child: Loader());
          } else {
            var recentExamList =
                dashboardScreenProvider.dashBoardData.recentExam;

            if (dashboardScreenProvider.dashBoardData.recentExam.length == 0) {
              return DashBoardWidgetsPlaceHolderWidgets(
                child: Text(
                  StringUtils.noExamText,
                  style: Theme.of(context).textTheme.title,
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recentExamList.length > 3 ? 3 : recentExamList.length,
              itemBuilder: (context, index) {
                return RecentExamListTileWidget(
                  index: index,
                  recentExamModel: recentExamList[index],
                );
              },
              separatorBuilder: (context, i) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    height: 2,
                    color: Colors.grey,
                  ),
                );
              },
            );
          }
        }),
      ],
    );
  }
}

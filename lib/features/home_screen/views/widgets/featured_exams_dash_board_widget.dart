import 'package:p7app/features/featured_exam_screen/views/featured_exams_screen.dart';
import 'package:p7app/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:p7app/features/home_screen/views/widgets/dash_board_widgets_place_holder_widgets.dart';
import 'package:p7app/features/home_screen/views/widgets/view_more_button_widget.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'featured_exam_card_item.dart';

class FeaturedExamsDashBoardWidget extends StatefulWidget {
  FeaturedExamsDashBoardWidget({Key key}) : super(key: key);

  @override
  _FeaturedExamsDashBoardWidgetState createState() =>
      _FeaturedExamsDashBoardWidgetState();
}

class _FeaturedExamsDashBoardWidgetState
    extends State<FeaturedExamsDashBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                StringUtils.featuredExamsText,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Consumer<DashboardScreenProvider>(
                builder: (context, dashBoardScreenProvider, child) {
                  if (dashBoardScreenProvider.dashBoardData != null) {
                    if (dashBoardScreenProvider.dashBoardData.featuredExam.length <=
                        3) {
                      return SizedBox();
                    } else {
                      return ViewMoreButtonWidget(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => FeaturedExamsScreen()));
                        },
                      );
                    }
                  }
                  return SizedBox();
                }),

          ],
        ),
        SizedBox(
          height: 10,
        ),
        Consumer<DashboardScreenProvider>(
            builder: (context, dashboardScreenProvider, c) {
          if (dashboardScreenProvider.dashBoardData == null) {
            return DashBoardWidgetsPlaceHolderWidgets(child: Loader());
          } else {
            var featuredExamList =
                dashboardScreenProvider.dashBoardData.featuredExam;

            if (dashboardScreenProvider.dashBoardData.featuredExam.length ==
                0) {
              return DashBoardWidgetsPlaceHolderWidgets(
                child: Text(
                  StringUtils.noExamText,
                  style: Theme.of(context).textTheme.title,
                ),
              );
            }

            return Container(
              height: 300.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: featuredExamList.length,
                itemBuilder: (context, index) {
                  return FeaturedExamCardItem(
                      featuredExamModel: featuredExamList[index],
                      index: index);
                },
              ),
            );
          }
        }),
      ],
    );
  }
}

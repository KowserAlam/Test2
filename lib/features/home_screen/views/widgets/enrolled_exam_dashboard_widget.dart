import 'package:p7app/features/enrolled_exam_list_screen/view/enroll_exam_list_tile.dart';
import 'package:p7app/features/enrolled_exam_list_screen/view/enrolled_exam_list_screen.dart';
import 'package:p7app/features/home_screen/models/dashboard_models.dart';
import 'package:p7app/features/enrolled_exam_list_screen/models/enrolled_exam_model.dart';
import 'package:p7app/features/home_screen/views/widgets/dash_board_widgets_place_holder_widgets.dart';
import 'package:p7app/features/home_screen/views/widgets/exam_duration_widget.dart';
import 'package:p7app/features/home_screen/views/widgets/view_more_button_widget.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/util/const.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/dashboard_screen_provider.dart';

class EnrolledExamListDashBoardWidget extends StatefulWidget {
  @override
  _EnrolledExamListDashBoardWidgetState createState() =>
      _EnrolledExamListDashBoardWidgetState();
}

class _EnrolledExamListDashBoardWidgetState
    extends State<EnrolledExamListDashBoardWidget> {
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
                StringUtils.enrolledExamsText,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Consumer<DashboardScreenProvider>(
                builder: (context, dashBoardScreenProvider, child) {
              if (dashBoardScreenProvider.dashBoardData != null) {
                if (dashBoardScreenProvider
                        .dashBoardData.enrolledExams.length <=
                    3) {
                  return SizedBox();
                }
                return ViewMoreButtonWidget(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (_) => EnrolledExamScreen()));
                  },
                );
              }

              return SizedBox();
            }),
          ],
        ),
        Consumer<DashboardScreenProvider>(
            builder: (context, dashBoardScreenProvider, child) {
          if (dashBoardScreenProvider.dashBoardData == null) {
            return DashBoardWidgetsPlaceHolderWidgets(child: Loader());
          } else {
            List<EnrolledExamModel> enrolledExamList =
                dashBoardScreenProvider.dashBoardData.enrolledExams;
            if (dashBoardScreenProvider.dashBoardData.enrolledExams.length ==
                0) {
              if (dashBoardScreenProvider.dashBoardData.enrolledExams.length ==
                  0) {
                return DashBoardWidgetsPlaceHolderWidgets(
                  child: Text(
                    StringUtils.noExamText,
                    style: Theme.of(context).textTheme.title,
                  ),
                );
              }
              return DashBoardWidgetsPlaceHolderWidgets(
                child: Text(
                  StringUtils.noExamText,
                  style: Theme.of(context).textTheme.title,
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  enrolledExamList.length > 3 ? 3 : enrolledExamList.length,
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    height: 2,
                    color: Colors.grey,
                  ),
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return new EnrolledExamListTileWidget(
                    enrolledExamModel: enrolledExamList[index]);
              },
            );
          }
        }),
      ],
    );
  }
}

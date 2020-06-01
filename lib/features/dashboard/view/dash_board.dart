import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/dashboard/view/widgets/info_box_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/job_chart_widget.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false).getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.dashBoardText),
      ),
      drawer: AppDrawer(
        routeName: 'dashboard',
      ),
      body: RefreshIndicator(
        onRefresh: Provider.of<DashboardViewModel>(context, listen: false)
            .getDashboardData,
        child: ListView(
          children: [
            InfoBoxWidget(),
            JobChartWidget(),
          ],
        ),
      ),
    );
  }
}

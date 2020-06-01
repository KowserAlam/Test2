import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:p7app/features/dashboard/models/skill_job_chart_data_model.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:provider/provider.dart';

class JobChartWidget extends StatelessWidget {
  final bool animate;

  JobChartWidget({this.animate = false});

  @override
  Widget build(BuildContext context) {
    var dashboardViewModel = Provider.of<DashboardViewModel>(context);
    var dataList = [
      SkillJobChartDataModel(month: "July", total: 40),
      SkillJobChartDataModel(month: "August", total: 400),
      SkillJobChartDataModel(month: "September", total: 300),
      SkillJobChartDataModel(month: "October", total: 100),
      SkillJobChartDataModel(month: "November", total: 80),
      SkillJobChartDataModel(month: "December", total: 60),
    ];
    var seriesList = [
      charts.Series<SkillJobChartDataModel, String>(
          id: "JoB Chart",
          domainFn: (v, _) => v.month ?? "Month",
          measureFn: (v, _) => v.total ?? 0,
          data: dashboardViewModel.skillJobChartData,
          labelAccessorFn: (v, _) =>
          '${v.total??""}',
      )
    ];

    return Container(
      padding: EdgeInsets.all(8),
      height: 250,
      child: charts.BarChart(
        seriesList,
        barGroupingType: charts.BarGroupingType.grouped,
        vertical: false,
        animate: animate,
//        flipVerticalAxis: true,
        barRendererDecorator: new charts.BarLabelDecorator<String>(),

      behaviors: [
        new charts.ChartTitle('Jobs per month',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
            charts.OutsideJustification.middleDrawArea),

      ],
        primaryMeasureAxis: new charts.NumericAxisSpec(
            tickProviderSpec:
                new charts.BasicNumericTickProviderSpec(desiredTickCount: 10)),
        secondaryMeasureAxis: new charts.NumericAxisSpec(
            tickProviderSpec:
                new charts.BasicNumericTickProviderSpec(desiredTickCount: 3)),
      ),
    );
  }
}

class SkillJobChartDataModel {
  String month;
  int total;

  SkillJobChartDataModel({this.month, this.total});

  SkillJobChartDataModel.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    total = json['total'];
  }

}
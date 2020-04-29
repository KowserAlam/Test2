import 'package:p7app/main_app/util/method_extension.dart';

class ExperienceInfo {
  int experienceId;
  String organizationName;
  String organizationId;
  String designation;
  DateTime startDate;
  DateTime endDate;

  ExperienceInfo(
      {this.organizationName, this.designation, this.startDate, this.endDate,this.organizationId,this.experienceId});

  ExperienceInfo.fromJson(Map<String, dynamic> json) {
    experienceId = json['id'];
    organizationName = json['company_text'];
    organizationId = json['company_id'];
    designation = json['designation'];
    if(json['start_date'] != null){
      startDate = DateTime.parse(json['start_date']);
    }

    if(json['end_date'] != null){
      endDate = DateTime.parse(json['end_date']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.experienceId;
    data['company_text'] = this.organizationName;
    data['company_id'] = this.organizationId;
    data['designation'] = this.designation;
    data['start_date'] = this.startDate.toYYYMMDDString;
    data['end_date'] = this.endDate.toYYYMMDDString;
    return data;
  }
}
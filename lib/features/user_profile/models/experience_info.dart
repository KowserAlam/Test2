import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/util/method_extension.dart';

class ExperienceInfo {
  int experienceId;
  String organizationName;
  String companyId;
  String designation;
  DateTime startDate;
  DateTime endDate;
  String companyProfilePic;

  ExperienceInfo({
    this.organizationName,
    this.designation,
    this.startDate,
    this.endDate,
    this.companyId,
    this.experienceId,
    this.companyProfilePic,
  });

  ExperienceInfo.fromJson(Map<String, dynamic> json) {
    var baseUrl = FlavorConfig?.instance?.values?.baseUrl;

    experienceId = json['id'];
    organizationName = json['company_text'];
    companyId = json['company'];
    designation = json['designation'];
    if (json['start_date'] != null) {
      startDate = DateTime.parse(json['start_date']);
    }

    if (json['end_date'] != null) {
      endDate = DateTime.parse(json['end_date']);
    }
    if (json['profile_pic'] != null) {
      companyProfilePic = "${baseUrl}${json['profile_pic']}";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.experienceId;
    data['company_text'] = this.organizationName;
    data['company_id'] = this.companyId;
    data['designation'] = this.designation;
    data['start_date'] = this.startDate.toYYYMMDDString;
    data['end_date'] = this.endDate.toYYYMMDDString;
    return data;
  }
}

import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/method_extension.dart';

class ExperienceInfo {
  String experienceId;
  String companyName;
  String companyId;
  String designation;
  DateTime startDate;
  DateTime endDate;
  String companyProfilePic;
  bool isCurrentlyWorkingHere;

  ExperienceInfo({
    this.companyName,
    this.designation,
    this.startDate,
    this.endDate,
    this.companyId,
    this.experienceId,
    this.companyProfilePic,
    this.isCurrentlyWorkingHere,
  });

  ExperienceInfo.fromJson(Map<String, dynamic> json) {
    var baseUrl = FlavorConfig?.instance?.values?.baseUrl;

    isCurrentlyWorkingHere = json['is_currently_working'];
    experienceId = json['id']?.toString();
    companyName = json['company_text'];
    companyId = json['company_id'];
    designation = json['designation'];
    if (json['start_date'] != null) {
      startDate = DateTime.parse(json['start_date']);
    }

    if (json['end_date'] != null) {
      endDate = DateTime.parse(json['end_date']);
    }
    if (json['company'] != null) {
      companyProfilePic = "${baseUrl}${json['company']['profile_picture']}";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.experienceId;
    data['company_text'] = this.companyName;
    data['company_id'] = this.companyId;
    data['designation'] = this.designation;
    data['start_date'] = this.startDate.toYYYMMDDString;
    data['end_date'] = this.endDate.toYYYMMDDString;
    return data;
  }
}

import 'package:p7app/features/user_profile/models/institution.dart';
import 'package:p7app/features/user_profile/models/major.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/method_extension.dart';

class EduInfo {
  int educationId;
  String degree;
  String educationLevel;
  int institutionId;
  String institutionText;
  String cgpa;
  MajorSubject major;
  String majorText;
  DateTime enrolledDate;
  DateTime graduationDate;
  String description;
  Institution institutionObj;

  EduInfo(
      {this.educationId,
      this.educationLevel,
      this.degree,
      this.institutionId,
      this.institutionText,
      this.cgpa,
      this.major,
      this.majorText,
      this.enrolledDate,
      this.graduationDate,
      this.description,
      this.institutionObj});

  EduInfo.fromJson(Map<String, dynamic> json) {
    educationId = json['id'];
    degree = json['degree'];
    educationLevel = json['education_level'];
    description = json['description'];
    institutionId = json['institution_id'];
    institutionText = json['institution_text'];
    cgpa = json['cgpa'];

    if (json['major_obj'] != null) {
      major = json['major_obj']['id'] == null
          ? null
          : MajorSubject.fromJson(json['major_obj']);
    }
    majorText = json['major_text'];
    enrolledDate = json['enrolled_date'] == null
        ? null
        : DateTime.parse(json['enrolled_date']);
    graduationDate = json['graduation_date'] == null
        ? null
        : DateTime.parse(json['graduation_date']);
    if (json['institution_obj'] != null) {
      institutionObj = json['institution_obj']['id'] != null
          ? new Institution.fromJson(json['institution_obj'])
          : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['degree_id'] = this.degree;
    data['institution_id'] = this.institutionId;
    data['education_level_id'] = this.educationLevel;
    data['description'] = this.description;
    data['institution_text'] = this.institutionText;
    data['cgpa'] = this.cgpa;
    data['major_id'] = this.major?.id;
    data['major_text'] = this.majorText;
    data['enrolled_date'] = this.enrolledDate.toYYYMMDDString;
    data['graduation_date'] = this.graduationDate.toYYYMMDDString;
    return data;
  }
}

import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/models/job_model.dart';

class RecentActivityModel {
  String description;
  String time;
  ActivityType type;
  JobListModel reletedJob;
  String updatedSection;

  RecentActivityModel(
      {this.description,
      this.time,
      this.type,
      this.reletedJob,
      this.updatedSection});

  RecentActivityModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    time = json['time'];

    if (json['type'] != null) {
      if (json['type'] == "apply_pro") {
        type = ActivityType.apply_pro;
      } else if (json['type'] == "update_pro") {
        type = ActivityType.update_pro;
      }else if (json['type'] == "favorite_pro") {
        type = ActivityType.favorite_pro;
      }
    }

    reletedJob = json['releted_job'] != null
        ? new JobListModel.fromJson(json['releted_job'])
        : null;
    updatedSection = json['updated_section'];
  }
}

enum ActivityType {
  update_pro,
  apply_pro,
  favorite_pro,
}

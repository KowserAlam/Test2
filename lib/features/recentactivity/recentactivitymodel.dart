import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/models/job_model.dart';

class RecentActivityModel {
  String description;
  String time;
  String type;
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
    type = json['type'];
    reletedJob = json['releted_job'] != null
        ? new JobListModel.fromJson(json['releted_job'])
        : null;
    updatedSection = json['updated_section'];
  }

}


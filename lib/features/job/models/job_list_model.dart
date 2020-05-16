import 'package:p7app/main_app/flavour/flavour_config.dart';

class JobListModel {
  String jobId;
  String slug;
  String title;
  String jobLocation;
  String employmentStatus;
  String companyName;
  String profilePicture;
  String jobNature;
  String jobSite;
  String jobType;
  bool isFavourite;
  bool isApplied;
  DateTime postDate;
  DateTime applicationDeadline;
  DateTime createdAt;
  DateTime publishDate;

  JobListModel({
    this.jobId,
    this.slug,
    this.title,
    this.jobLocation,
    this.employmentStatus,
    this.companyName,
    this.profilePicture,
    this.jobNature,
    this.jobSite,
    this.jobType,
    this.isApplied,
    this.isFavourite,
    this.postDate,
    this.applicationDeadline,
    this.createdAt,
  });

  JobListModel.fromJson(Map<String, dynamic> json) {
    String baseUrl = FlavorConfig?.instance?.values?.baseUrl;

    jobId = json['job_id'];
    slug = json['slug'];
    title = json['title'];
    jobLocation = json['job_location'];
    employmentStatus = json['employment_status'];
    companyName = json['company_name'];
    if (json['profile_picture'] != null) {
      profilePicture = "$baseUrl${json['profile_picture']}";
    }
    jobNature = json['job_nature'];
    jobSite = json['job_site'];
    jobType = json['job_type'];
    isApplied = json['is_applied'] == null
        ? false
        : (json['is_applied'][0] == "Yes" ? true : false);
    isFavourite = json['is_favourite'] == null
        ? false
        : (json['is_favourite'][0] == "Yes" ? true : false);

    this.postDate = json['post_date'];

    if (json['application_deadline'] != null) {
      applicationDeadline = DateTime.parse(json['application_deadline']);
    }
    if (json['created_date'] != null) {
      createdAt = DateTime.parse(json['created_date']);
    }
    if (json['publish_date'] != null) {
      publishDate = DateTime.parse(json['publish_date']);
    }

    if (json['post_date'] != null) {
      postDate = DateTime.parse(json['post_date']);
    }
  }
}

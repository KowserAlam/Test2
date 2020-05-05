class JobListModel{
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
  String postDate;
  String applicationDeadline;
  String createdAt;


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

  JobListModel.fromJson(Map<String, dynamic> json){
    jobId = json['job_id'];
    slug = json['slug'];
    title = json['title'];
    jobLocation = json['job_location'];
    employmentStatus = json['employment_status'];
    companyName = json['company_name'];
    profilePicture = json['profile_picture'];
    jobNature = json['job_nature'];
    jobSite = json['job_site'];
    jobType = json['job_type'];
    isApplied = json['is_applied'] == null ? false : (json['is_applied'] == "Yes" ? true : false);
    applicationDeadline = json['application_deadline'];
    isFavourite = json['is_favourite'] == null ? false : (json['is_favourite'] == "Yes" ? true : false);
    this.postDate = json['post_date'];
    this.createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['slug'] = this.slug;
    data['title'] = this.slug;
    data['job_location'] = this.jobLocation;
    data['employment_status'] = this.employmentStatus;
    data['company_name'] = this.companyName;
    data['profile_picture'] = this.profilePicture;
    data['job_type'] = this.jobType;
    data['job_site'] = this.jobSite;
    data['job_nature'] = this.jobNature;
    //data['is_favourite'] = this.isFavourite;
    //data['is_applied'] = this.isApplied;
    data['post_date'] = this.postDate;
    data['application_deadline'] = this.applicationDeadline;
    data['created_at'] = this.createdAt;
    return data;
  }
}
class JobListModel{
  String jobId;
  String slug;
  String title;
  String jobLocation;
  String employmentStatus;
  String companyName;
  String profilePicture;

  JobListModel({
    this.jobId,
    this.slug,
    this.title,
    this.jobLocation,
    this.employmentStatus,
    this.companyName,
    this.profilePicture
  });

  JobListModel.fromJson(Map<String, dynamic> json){
    jobId = json['job_id'];
    slug = json['slug'];
    title = json['title'];
    jobLocation = json['job_location'];
    employmentStatus = json['employment_status'];
    companyName = json['company_name'];
    profilePicture = json['profile_picture'];
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
    return data;
  }
}
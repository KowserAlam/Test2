import 'package:p7app/main_app/flavour/flavour_config.dart';

class JobModel {
  String jobId;
  String slug;
  String title;
  String jobLocation;
  String salaryMin;
  String salaryMax;
  int vacancy;
  DateTime applicationDeadline;
  String descriptions;
  String responsibilities;
  String education;
  String salary;
  String otherBenefits;
  String rawContent;
  String webAddress;
  bool termsAndCondition;
  DateTime createdAt;
  String industry;
  String employmentStatus;
  String experience;
  String qualification;
  String gender;
  String currency;
  String companyName;
  String division;
  String district;
  List<String> jobSkills;
  List<String> skill;
  bool isApplied;
  bool isFavourite;
  String profilePicture;
  DateTime publishDate;
  DateTime postDate;

  JobModel({
    this.jobId,
    this.slug,
    this.title,
    this.jobLocation,
    this.publishDate,
    this.salaryMin,
    this.salaryMax,
    this.vacancy,
    this.applicationDeadline,
    this.descriptions,
    this.responsibilities,
    this.education,
    this.isApplied,
    this.salary,
    this.otherBenefits,
    this.rawContent,
    this.webAddress,
    this.termsAndCondition,
    this.createdAt,
    this.industry,
    this.employmentStatus,
    this.experience,
    this.qualification,
    this.gender,
    this.currency,
    this.companyName,
    this.division,
    this.district,
    this.jobSkills,
    this.isFavourite,
    this.profilePicture,
    this.skill,
    this.postDate
  });

  JobModel.fromJson(Map<String, dynamic> json) {
    String baseUrl = FlavorConfig?.instance?.values?.baseUrl;

    jobId = json['job_id'];
    slug = json['slug'];
    title = json['title'];
    jobLocation = json['job_location'];
    salaryMin = json['salary_min'];
    salaryMax = json['salary_max'];
    vacancy = json['vacancy'];
    if(json['application_deadline'] != null){
      applicationDeadline = DateTime.parse(json['application_deadline']);
    }
    if(json['created_at'] != null){
      createdAt = DateTime.parse(json['created_at']);
    }
    if(json['publish_date'] != null){
      publishDate = DateTime.parse(json['publish_date']);
    }

    if(json['post_date'] != null){
      postDate = DateTime.parse(json['post_date']);
    }

    descriptions = json['descriptions'];
    responsibilities = json['responsibilities'];
    education = json['education'];
    salary = json['salary']?.toString();
    otherBenefits = json['other_benefits'];
    rawContent = json['raw_content'];
    webAddress = json['web_address'];
    termsAndCondition = json['terms_and_condition'];
    industry = json['industry'];
    employmentStatus = json['employment_status'];
    experience = json['experience'];
    qualification = json['qualification'];
    gender = json['gender'];
    currency = json['currency'];
    companyName = json['company_name'];
    division = json['division'];
    district = json['district'];
    jobSkills = json['job_skills']?.cast<String>();
    skill = json['skill']?.cast<String>();

    isApplied = json['is_applied'] == null ? false : (json['is_applied'] == "Yes" ? true : false);
    isFavourite = json['is_favourite'] == null ? false : (json['is_favourite'] == "Yes" ? true : false);
    if(json['profile_picture'] != null){
      profilePicture = "$baseUrl${json['profile_picture']}";
    }
  }


}

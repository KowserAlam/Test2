import 'dart:math';

class JobDetailModel{
  String status;
  bool is_applied;
  String job_id;
  String title;
  String industry;
  String employment_status;
  String job_location;
  String experience;
  String salary_min;
  String salary_max;
  String qualification;
  String gender;
  String currency;
  String vacancy;
  String application_deadline;
  String descriptions;
  String responsibilities;
  String education;
  String salary;
  String other_benefits;
  String company_name;
  String division;
  String district;
  String zipcode;
  String company_location;
  String company_profile;
  String latitude;
  String longitude;
  String raw_content;
  String web_address;
  String terms_and_conditions;
  String created_date;
  //String job_skills;
  String slug;
  //String skill;
  String profile_picture;

  JobDetailModel({
    this.status,
    this.is_applied,
    this.job_id,
    this.title,
    this.industry,
    this.employment_status,
    this.job_location,
    this.experience,
    this.salary_min,
    this.salary_max,
    this.qualification,
    this.gender,
    this.currency,
    this.vacancy,
    this.application_deadline,
    this.descriptions,
    this.responsibilities,
    this.education,
    this.salary,
    this.other_benefits,
    this.company_name,
    this.division,
    this.district,
    this.zipcode,
    this.company_location,
    this.company_profile,
    this.latitude,
    this.longitude,
    this.raw_content,
    this.web_address,
    this.terms_and_conditions,
    this.created_date,
    this.slug,
    this.profile_picture,
  });

  JobDetailModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    is_applied = json['is_applied'];
    job_id = json['job_id'];
    title = json['title'];
    industry = json['industry'];
    employment_status = json['employment_status'];
    job_location = json['job_location'];
    experience = json['experience'];
    salary_min = json['salary_min'];
    salary_max = json['salary_max'];
    qualification = json['qualification'];
    gender = json['gender'];
    currency = json['currency'];
    vacancy = json['vacancy'];
    application_deadline = json['application_deadline'];
    descriptions = json['descriptions'];
    responsibilities = json['responsibilities'];
    education = json['education'];
    salary = json['salary'];
    other_benefits = json['other_benifits'];
    company_name = json['company_name'];
    division = json['division'];
    district = json['district'];
    zipcode = json['zipcode'];
    company_location = json['company_location'];
    company_profile = json['company_profile'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    raw_content = json['raw_content'];
    web_address = json['web_address'];
    terms_and_conditions = json['terms_and_conditions'];
    created_date = json['created_date'];
    slug = json['slug'];
    profile_picture = json['profile_picture'];
  }
}
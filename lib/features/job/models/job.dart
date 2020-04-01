class JobModel {
  String jobId;
  String title;
  String jobLocation;
  String salaryMin;
  String salaryMax;
  int vacancy;
  String applicationDeadline;
  String descriptions;
  String responsibilities;
  String education;
  double salary;
  String otherBenefits;
  String rawContent;
  String webAddress;
  bool termsAndCondition;
  String createdDate;
  String industry;
  String employmentStatus;
  String experience;
  String qualification;
  String gender;
  String currency;
  String companyName;
  String division;
  Null district;
  List<String> jobSkills;

  JobModel(
      {this.jobId,
        this.title,
        this.jobLocation,
        this.salaryMin,
        this.salaryMax,
        this.vacancy,
        this.applicationDeadline,
        this.descriptions,
        this.responsibilities,
        this.education,
        this.salary,
        this.otherBenefits,
        this.rawContent,
        this.webAddress,
        this.termsAndCondition,
        this.createdDate,
        this.industry,
        this.employmentStatus,
        this.experience,
        this.qualification,
        this.gender,
        this.currency,
        this.companyName,
        this.division,
        this.district,
        this.jobSkills});

  JobModel.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    title = json['title'];
    jobLocation = json['job_location'];
    salaryMin = json['salary_min'];
    salaryMax = json['salary_max'];
    vacancy = json['vacancy'];
    applicationDeadline = json['application_deadline'];
    descriptions = json['descriptions'];
    responsibilities = json['responsibilities'];
    education = json['education'];
    salary = json['salary'];
    otherBenefits = json['other_benefits'];
    rawContent = json['raw_content'];
    webAddress = json['web_address'];
    termsAndCondition = json['terms_and_condition'];
    createdDate = json['created_date'];
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
 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['title'] = this.title;
    data['job_location'] = this.jobLocation;
    data['salary_min'] = this.salaryMin;
    data['salary_max'] = this.salaryMax;
    data['vacancy'] = this.vacancy;
    data['application_deadline'] = this.applicationDeadline;
    data['descriptions'] = this.descriptions;
    data['responsibilities'] = this.responsibilities;
    data['education'] = this.education;
    data['salary'] = this.salary;
    data['other_benefits'] = this.otherBenefits;
    data['raw_content'] = this.rawContent;
    data['web_address'] = this.webAddress;
    data['terms_and_condition'] = this.termsAndCondition;
    data['created_date'] = this.createdDate;
    data['industry'] = this.industry;
    data['employment_status'] = this.employmentStatus;
    data['experience'] = this.experience;
    data['qualification'] = this.qualification;
    data['gender'] = this.gender;
    data['currency'] = this.currency;
    data['company_name'] = this.companyName;
    data['division'] = this.division;
    data['district'] = this.district;
    data['job_skills'] = this.jobSkills;
    return data;
  }
}
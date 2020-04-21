class EduInfo {
  String qualification;
  String educationId;
  String institution;
  String cgpa;
  String major;
  String enrolledDate;
  String graduationDate;

  EduInfo(
      {this.qualification,
        this.institution,
        this.cgpa,
        this.major,
        this.enrolledDate,
        this.graduationDate});

  EduInfo.fromJson(Map<String, dynamic> json) {
    educationId = json['education_id'];
    qualification = json['qualification'];
    institution = json['institution'];
    cgpa = json['cgpa'];
    major = json['major'];
    enrolledDate = json['enrolled_date'];
    graduationDate = json['graduation_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qualification'] = this.qualification;
    data['institution'] = this.institution;
    data['cgpa'] = this.cgpa;
    data['major'] = this.major;
    data['enrolled_date'] = this.enrolledDate;
    data['graduation_date'] = this.graduationDate;
    return data;
  }
}
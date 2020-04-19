

import 'package:p7app/main_app/flavour/flavour_config.dart';

class UserPersonalInfo {
  String id;
  String professionalId;
  String fullName;
  String email;
  String phone;
  String address;
  String aboutMe;
  String image;
  String password;
  String fatherName;
  String motherName;
  String facebbokId;
  String twitterId;
  String linkedinId;
  DateTime dateOfBirth;
  String expectedSalaryMin;
  String expectedSalaryMax;
  String industryExpertise;
  int user;
  String gender;
  String status;
  String experience;
  String qualification;
  String nationality;

  UserPersonalInfo(
      {this.id,
        this.professionalId,
        this.fullName,
        this.email,
        this.phone,
        this.address,
        this.aboutMe,
        this.image,
        this.password,
        this.fatherName,
        this.motherName,
        this.facebbokId,
        this.twitterId,
        this.linkedinId,
        this.dateOfBirth,
        this.expectedSalaryMin,
        this.expectedSalaryMax,
        this.industryExpertise,
        this.user,
        this.gender,
        this.status,
        this.experience,
        this.qualification,
        this.nationality});

  UserPersonalInfo.fromJson(Map<String, dynamic> json) {
    String baseUrl = FlavorConfig.instance.values.baseUrl;
    var imageUlr = json['image'] == null? null: "$baseUrl${json['image']}";

    id = json['id'];
    professionalId = json['professional_id'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    aboutMe = json['about_me'];
    image = imageUlr;
    password = json['password'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    facebbokId = json['facebbok_id'];
    twitterId = json['twitter_id'];
    linkedinId = json['linkedin_id'];
    if(json['date_of_birth'] != null){
      dateOfBirth = DateTime.parse(json['date_of_birth']);
    }

    expectedSalaryMin = json['expected_salary_min'];
    expectedSalaryMax = json['expected_salary_max'];
    industryExpertise = json['industry_expertise'];
    user = json['user'];
    gender = json['gender'];
    status = json['status'];
    experience = json['experience'];
    qualification = json['qualification'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['professional_id'] = this.professionalId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['about_me'] = this.aboutMe;
    data['image'] = this.image;
    data['password'] = this.password;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['facebbok_id'] = this.facebbokId;
    data['twitter_id'] = this.twitterId;
    data['linkedin_id'] = this.linkedinId;
    data['date_of_birth'] = this.dateOfBirth.toIso8601String();
    data['expected_salary_min'] = this.expectedSalaryMin;
    data['expected_salary_max'] = this.expectedSalaryMax;
    data['industry_expertise'] = this.industryExpertise;
    data['user'] = this.user;
    data['gender'] = this.gender;
    data['status'] = this.status;
    data['experience'] = this.experience;
    data['qualification'] = this.qualification;
    data['nationality'] = this.nationality;
    return data;
  }
}












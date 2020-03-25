

class UserProfileModel {
  int id;
  String displayName;
  String email;
  String mobileNumber;
  String designation;
  String city;
  String about;
  String profilePicUrl;

  PersonalInfo personalInfo;

  List<Education> educationModelList;

  List<TechnicalSkill> technicalSkillList;

  List<Experience> experienceList;

  UserProfileModel(
      {this.displayName,
      this.email,
      this.mobileNumber,
      this.personalInfo,
      this.designation,
      this.city,
      this.about,
      this.id,
      this.profilePicUrl,
      this.educationModelList,
      this.technicalSkillList,
      this.experienceList});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    displayName = json['name'];
    mobileNumber = json['mobile_number'];
    id = json['id'];
    profilePicUrl = json['profile_pic_url'];
    email = json['email'];
    about = json['about'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.displayName;
    data['mobile_number'] = this.mobileNumber;
    data['id'] = this.id;
    data['profile_pic_url'] = this.profilePicUrl;
    data['email'] = this.email;
    data['about'] = this.about;
    data['city'] = this.city;
    return data;
  }
}

class Experience {
  String organizationName;
  String id;
  String position;
  String role;
  DateTime joiningDate;
  DateTime leavingDate;
  bool currentlyWorkHere;

  Experience(
      {this.organizationName,
      this.position,
      this.id,
      this.role,
      this.joiningDate,
      this.leavingDate,
      this.currentlyWorkHere});

//  factory Experience.fromJson(json) {
//    return _$ExperienceFromJson(json);
//  }
//
//  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}

class Education {
  String id;
  String nameOfInstitution;
  String gpa;
  DateTime passingYear;
  String degree;
  bool currentlyStudyingHere;

  Education(
      {this.nameOfInstitution,
      this.gpa,
      this.id,
      this.degree,
      this.passingYear,
      this.currentlyStudyingHere});

//  factory Education.fromJson(json) {
//    return _$EducationFromJson(json);
//  }
//
//  Map<String, dynamic> toJson() => _$EducationToJson(this);
}

class TechnicalSkill {
  String id;
  String skillName;
  double level;
  bool isVerified;

  TechnicalSkill({this.skillName, this.id, this.level, this.isVerified});
//
//  factory TechnicalSkill.fromJson(json) {
//    return _$TechnicalSkillFromJson(json);
//  }
//
//  Map<String, dynamic> toJson() => _$TechnicalSkillToJson(this);
}

class PersonalInfo {
  String fatherName;
  String motherName;
  String currentAddress;
  String permanentAddress;
  String religion;
  DateTime dateOfBirth;
  String gender;
  String nationality;
  List<String> languages;
  String maritalStatus;

  PersonalInfo(
      {this.fatherName,
      this.motherName,
      this.currentAddress,
      this.permanentAddress,
      this.religion,
      this.dateOfBirth,
      this.gender,
      this.nationality,
      this.languages,
      this.maritalStatus});
}

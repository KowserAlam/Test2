class ExperienceInfo {
  int experienceId;
  String company;
  String designation;
  DateTime startedDate;
  DateTime endDate;

  ExperienceInfo(
      {this.company, this.designation, this.startedDate, this.endDate});

  ExperienceInfo.fromJson(Map<String, dynamic> json) {
    experienceId = json['experience_id'];
    company = json['company'];
    designation = json['designation'];

    if(json['Started_date'] != null){
      startedDate = DateTime.parse(json['Started_date']);
    }

    if(json['end_date'] != null){
      endDate = DateTime.parse(json['end_date']);
    }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['experience_id'] = this.experienceId;
    data['company'] = this.company;
    data['designation'] = this.designation;
    data['Started_date'] = this.startedDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
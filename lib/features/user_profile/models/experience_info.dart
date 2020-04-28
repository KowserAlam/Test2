class ExperienceInfo {
  int experienceId;
  String organizationName;
  int organizationId;
  String designation;
  DateTime startedDate;
  DateTime endDate;

  ExperienceInfo(
      {this.organizationName, this.designation, this.startedDate, this.endDate});

  ExperienceInfo.fromJson(Map<String, dynamic> json) {
    experienceId = json['id'];
    organizationName = json['company_text'];
    organizationId = json['company_id'];
    designation = json['designation'];
    if(json['start_date'] != null){
      startedDate = DateTime.parse(json['start_date']);
    }

    if(json['end_date'] != null){
      endDate = DateTime.parse(json['end_date']);
    }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.experienceId;
    data['company_text'] = this.organizationName;
    data['company_id'] = this.organizationId;
    data['designation'] = this.designation;
    data['start_date'] = this.startedDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
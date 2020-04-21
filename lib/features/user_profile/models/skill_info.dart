

class SkillInfo {
  int skillId;
  String skill;
  double rating;
  bool verifiedBySkillcheck;

  SkillInfo({this.skillId,this.skill, this.rating, this.verifiedBySkillcheck});

  SkillInfo.fromJson(Map<String, dynamic> json) {
    skillId = json['prof_skill_id'];
    skill = json['skill']?.toString();
    rating = json['rating'];
    verifiedBySkillcheck = json['verified_by_skillcheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skill'] = this.skill;
    data['rating'] = this.rating;
    data['verified_by_skillcheck'] = this.verifiedBySkillcheck;

    return data;
  }
}
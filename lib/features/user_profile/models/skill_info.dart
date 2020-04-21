

class SkillInfo {
  int profSkillId;
  String skillId;
  String skill;
  int rating;
  bool verifiedBySkillCheck;

  SkillInfo({this.profSkillId,this.skillId, this.rating, this.verifiedBySkillCheck});

  SkillInfo.fromJson(Map<String, dynamic> json) {
    profSkillId = json['prof_skill_id'];
    skill = json['skill']?.toString();
    skillId = json['name_id']?.toString();
    rating = json['rating'];
    verifiedBySkillCheck = json['verified_by_skillcheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_id'] = this.skillId;
    data['rating'] = this.rating;
    return data;
  }
}
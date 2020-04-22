import 'package:p7app/features/user_profile/models/skill.dart';

class SkillInfo {
  int profSkillId;
  Skill skill;
  int rating;
  bool verifiedBySkillCheck;

  SkillInfo({this.profSkillId, this.rating, this.verifiedBySkillCheck,this.skill});

  SkillInfo.fromJson(Map<String, dynamic> json) {
    profSkillId = json['id'];
    if (json['skill_obj'] != null) {
      skill = Skill.fromJson(json['skill_obj']);
    }
    rating = json['rating'];
    verifiedBySkillCheck = json['verified_by_skillcheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_id'] = this.skill?.id;
    data['rating'] = this.rating;
    return data;
  }
}

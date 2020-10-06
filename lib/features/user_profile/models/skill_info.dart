import 'package:equatable/equatable.dart';
import 'package:p7app/main_app/models/skill.dart';

class SkillInfo extends Equatable{
  String profSkillId;
  Skill skill;
  double rating;
  bool verifiedBySkillCheck;
  bool isTopSkill;

  SkillInfo({this.profSkillId, this.rating, this.verifiedBySkillCheck,this.skill,this.isTopSkill});

  SkillInfo.fromJson(Map<String, dynamic> json) {
    profSkillId = json['id']?.toString();
    if (json['skill_obj'] != null) {
      skill = Skill.fromJson(json['skill_obj']);
    }
    rating =  (json['rating'] as num)?.toDouble();
    verifiedBySkillCheck = json['verified_by_skillcheck']??false;
    isTopSkill = json['is_top_skill'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skill_name_id'] = this.skill?.id;
    data['rating'] = this.rating;
    data['is_top_skill'] = this.isTopSkill;
    return data;
  }

  Map<String, dynamic> toJsonCreateNew() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skill_name_id'] = this.skill?.id;
    data['rating'] = this.rating;
    data['is_top_skill'] = this.isTopSkill;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [this.profSkillId,this.skill,this.rating,this.verifiedBySkillCheck, this.isTopSkill];
}

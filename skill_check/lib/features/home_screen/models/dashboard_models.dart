import 'package:skill_check/features/enrolled_exam_list_screen/models/enrolled_exam_model.dart';
import 'package:skill_check/features/featured_exam_screen/models/featured_exam_model.dart';
import 'package:skill_check/features/recent_exam/models/recent_exam_model.dart';
import 'package:skill_check/main_app/util/const.dart';
import 'package:skill_check/main_app/api_helpers/urls.dart';



class DashBoardModel {
  UserDashBoard user;

  List<EnrolledExamModel> enrolledExams;

  List<RecentExamModel> recentExam;



  List<FeaturedExamModel> featuredExam;

  DashBoardModel({
    this.user,
    this.enrolledExams,
    this.recentExam,
    this.featuredExam,
  });

  factory DashBoardModel.fromJson(json) {
    var data = json['data'];
    return _$DashBoardModelFromJson(data);
  }

  Map<String, dynamic> toJson() => _$DashBoardModelToJson(this);
}

class UserDashBoard {
  String name;
  int id;

  String profilePicUrl;
  String email;

  UserDashBoard({
    this.email,
    this.name,
    this.profilePicUrl,
    this.id,
  });

  factory UserDashBoard.fromJson(json) {
    return _$UserDashBoardFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserDashBoardToJson(this);
}




DashBoardModel _$DashBoardModelFromJson(Map<String, dynamic> json) {
  return DashBoardModel(
      user: UserDashBoard.fromJson(json['user']),
      enrolledExams: (json['enrolled_exam'] as List)
          .map((e) => EnrolledExamModel.fromJson(e))
          .toList(),
      recentExam: (json['recent_exam'] as List)
          .map((e) => RecentExamModel.fromJson(e))
          .toList(),
      featuredExam: (json['featured_exam'] as List)
          .map((e) => FeaturedExamModel.fromJson(e))
          .toList());
}

Map<String, dynamic> _$DashBoardModelToJson(DashBoardModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'enrolled_exam': instance.enrolledExams,
      'recent_exam': instance.recentExam,
      'featured_exam': instance.featuredExam
    };

UserDashBoard _$UserDashBoardFromJson(Map<String, dynamic> json) {
  return UserDashBoard(
      email: json['email'] as String,
      name: json['name'] as String,
      profilePicUrl: json['profile_pic_url']?? kDefaultUserImageNetwork,
      id: json['id'] as int);
}

Map<String, dynamic> _$UserDashBoardToJson(UserDashBoard instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'profile_pic_url': instance.profilePicUrl,
      'id': instance.id
    };


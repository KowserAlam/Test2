import 'package:skill_check/main_app/util/json_keys.dart';

class AuthUserModel {
  String refresh;
  String accessToken;
  String email;
  String userId;
  String fullName;

  AuthUserModel(
      {this.refresh, this.accessToken, this.email, this.userId, this.fullName});

  AuthUserModel.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    accessToken = json['access'];
    email = json['email'];
    userId = json['user_id'].toString();
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.accessToken;
    data['email'] = this.email;
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    return data;
  }
}
import 'package:p7app/main_app/resource/json_keys.dart';

class AuthUserModel {
  String refresh;
  String accessToken;
  String email;
  String userId;
  String fullName;
  String professionalId;
  String professionalImage;

  AuthUserModel(
      {this.refresh, this.accessToken, this.email, this.userId, this.fullName});

  AuthUserModel.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    accessToken = json['access'];
    email = json['email'];
    userId = json['user_id'].toString();
    fullName = json['full_name'];
    professionalId = json['professional_id'];
    professionalImage = json['professional_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.accessToken;
    data['email'] = this.email;
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['professionalId'] = this.professionalId;
    data['professional_image'] = this.professionalImage;
    return data;
  }
}
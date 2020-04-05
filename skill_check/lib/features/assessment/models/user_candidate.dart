
class UserCandidate {
  String username;
  String regId;
  String status;

  UserCandidate({this.username, this.regId, this.status});

  UserCandidate.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    regId = json['reg_id'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['reg_id'] = this.regId;
    data['status'] = this.status;
    return data;
  }
}
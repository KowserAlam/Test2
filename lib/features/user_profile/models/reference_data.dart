class ReferenceData {
  String name;
  String currentPosition;
  String email;
  String mobile;

  ReferenceData({this.name, this.currentPosition, this.email, this.mobile});

  ReferenceData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    currentPosition = json['current_position'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['current_position'] = this.currentPosition;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    return data;
  }
}
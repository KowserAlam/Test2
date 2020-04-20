class ReferenceData {
  int referenceId;
  String name;
  String currentPosition;
  String email;
  String mobile;

  ReferenceData(
      {this.referenceId,
        this.name,
        this.currentPosition,
        this.email,
        this.mobile});

  ReferenceData.fromJson(Map<String, dynamic> json) {
    referenceId = json['reference_id'];
    name = json['name']?.toString();
    currentPosition = json['current_position']?.toString();
    email = json['email']?.toString();
    mobile = json['mobile']?.toString();
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
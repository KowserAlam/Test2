import 'package:p7app/main_app/util/method_extension.dart';

class MembershipInfo {
  int membershipId;
  String orgName;
  String positionHeld;
  bool membershipOngoing;
  DateTime startDate;
  DateTime endDate;
  String description;

  MembershipInfo(
      {this.membershipId,
        this.orgName,
        this.positionHeld,
        this.membershipOngoing,
        this.startDate,
        this.endDate,
        this.description});

  MembershipInfo.fromJson(Map<String, dynamic> json) {
    membershipId = json['membership_id'];
    orgName = json['organization']?.toString();
    positionHeld = json['position_held']?.toString();
    membershipOngoing = json['membership_ongoing'];
    if (json['start_date'] != null) {
      startDate = DateTime.parse(json['Start_date']);
    }
    if (json['end_date'] != null) {
      endDate = DateTime.parse(json['end_date']);
    }
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membership_id'] = this.membershipId;
    data['organization'] = this.orgName;
    data['position_held'] = this.positionHeld;
    data['membership_ongoing'] = this.membershipOngoing;
    data['start_date'] = this.startDate.toYYYMMDDString;
    data['end_date'] = this.endDate.toYYYMMDDString;
    data['description'] = this.description;
    return data;
  }
}
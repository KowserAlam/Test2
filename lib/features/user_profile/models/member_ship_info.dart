class MembershipInfo {
  int membershipId;
  String orgName;
  String positionHeld;
  bool membershipOngoing;
  DateTime startDate;
  DateTime endDate;
  String desceription;

  MembershipInfo(
      {this.membershipId,
        this.orgName,
        this.positionHeld,
        this.membershipOngoing,
        this.startDate,
        this.endDate,
        this.desceription});

  MembershipInfo.fromJson(Map<String, dynamic> json) {
    membershipId = json['membership_id'];
    orgName = json['org_name']?.toString();
    positionHeld = json['position_held']?.toString();
    membershipOngoing = json['membership_ongoing'];
    if (json['Start_date'] != null) {
      startDate = DateTime.parse(json['Start_date']);
    }
    if (json['end_date'] != null) {
      endDate = DateTime.parse(json['end_date']);
    }
    desceription = json['desceription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membership_id'] = this.membershipId;
    data['org_name'] = this.orgName;
    data['position_held'] = this.positionHeld;
    data['membership_ongoing'] = this.membershipOngoing;
    data['Start_date'] = this.startDate.toIso8601String();
    data['end_date'] = this.endDate.toIso8601String();
    data['desceription'] = this.desceription;
    return data;
  }
}
class MembershipInfo {
  int membershipId;
  String orgName;
  String positionHeld;
  bool membershipOngoing;
  String startDate;
  String endDate;
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
    startDate = json['Start_date'];
    endDate = json['end_date'];
    desceription = json['desceription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membership_id'] = this.membershipId;
    data['org_name'] = this.orgName;
    data['position_held'] = this.positionHeld;
    data['membership_ongoing'] = this.membershipOngoing;
    data['Start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['desceription'] = this.desceription;
    return data;
  }
}
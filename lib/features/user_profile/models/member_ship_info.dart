class MembershipInfo {
  String orgName;
  String positionHeld;
  String membershipOngoing;
  String startDate;
  String endDate;
  String desceription;

  MembershipInfo(
      {this.orgName,
        this.positionHeld,
        this.membershipOngoing,
        this.startDate,
        this.endDate,
        this.desceription});

  MembershipInfo.fromJson(Map<String, dynamic> json) {
    orgName = json['org_name'];
    positionHeld = json['position_held'];
    membershipOngoing = json['membership_ongoing'];
    startDate = json['Start_date'];
    endDate = json['end_date'];
    desceription = json['desceription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['org_name'] = this.orgName;
    data['position_held'] = this.positionHeld;
    data['membership_ongoing'] = this.membershipOngoing;
    data['Start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['desceription'] = this.desceription;
    return data;
  }
}
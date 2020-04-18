class CertificationInfo {
  String certificationName;
  String organizationName;
  String hasExpiryPeriod;
  String issueDate;
  String expiryDate;
  String credentialId;
  String credentialUrl;

  CertificationInfo(
      {this.certificationName,
        this.organizationName,
        this.hasExpiryPeriod,
        this.issueDate,
        this.expiryDate,
        this.credentialId,
        this.credentialUrl});

  CertificationInfo.fromJson(Map<String, dynamic> json) {
    certificationName = json['certification_name'];
    organizationName = json['organization_name'];
    hasExpiryPeriod = json['has_expiry_period'];
    issueDate = json['issue_date'];
    expiryDate = json['expiry_date'];
    credentialId = json['credential_id'];
    credentialUrl = json['credential_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['certification_name'] = this.certificationName;
    data['organization_name'] = this.organizationName;
    data['has_expiry_period'] = this.hasExpiryPeriod;
    data['issue_date'] = this.issueDate;
    data['expiry_date'] = this.expiryDate;
    data['credential_id'] = this.credentialId;
    data['credential_url'] = this.credentialUrl;
    return data;
  }
}
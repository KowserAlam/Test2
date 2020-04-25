class CertificationInfo {
  int certificationId;
  String certificationName;
  String organizationName;
  bool hasExpiryPeriod;
  String issueDate;
  String expiryDate;
  String credentialId;
  String credentialUrl;

  CertificationInfo(
      {this.certificationId,
        this.certificationName,
        this.organizationName,
        this.hasExpiryPeriod,
        this.issueDate,
        this.expiryDate,
        this.credentialId,
        this.credentialUrl});

  CertificationInfo.fromJson(Map<String, dynamic> json) {
    certificationId = json['certification_id'];
    certificationName = json['name']?.toString();
    organizationName = json['organization_name']?.toString();
    hasExpiryPeriod = json['has_expiry_period'];
    issueDate = json['issue_date'];
    expiryDate = json['expiry_date'];
    credentialId = json['credential_id'];
    credentialUrl = json['credential_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['certification_id'] = this.certificationId;
    data['name'] = this.certificationName;
    data['organization_name'] = this.organizationName;
    data['has_expiry_period'] = this.hasExpiryPeriod;
    data['issue_date'] = this.issueDate;
    data['expiry_date'] = this.expiryDate;
    data['credential_id'] = this.credentialId;
    data['credential_url'] = this.credentialUrl;
    return data;
  }
}
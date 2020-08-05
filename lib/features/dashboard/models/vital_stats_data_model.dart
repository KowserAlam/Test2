class VitalStatsDataModel {
  String professionalCount;
  String openJob;
  String resume;
  String companyCount;

  VitalStatsDataModel(
      {this.professionalCount, this.openJob, this.resume, this.companyCount});

  VitalStatsDataModel.fromJson(Map<String, dynamic> json) {
    professionalCount = json['professional_count'];
    openJob = json['open_job'];
    resume = json['resume'];
    companyCount = json['company_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['professional_count'] = this.professionalCount;
    data['open_job'] = this.openJob;
    data['resume'] = this.resume;
    data['company_count'] = this.companyCount;
    return data;
  }
}
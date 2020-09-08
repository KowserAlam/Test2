class VitalStatsDataModel {
  String numOfVacancy;
  String openJob;
  String resume;
  String companyCount;

  VitalStatsDataModel(
      {this.numOfVacancy, this.openJob, this.resume, this.companyCount});

  VitalStatsDataModel.fromJson(Map<String, dynamic> json) {
    numOfVacancy = json['num_of_vacancy'];
    openJob = json['open_job'];
    resume = json['resume'];
    companyCount = json['company_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['professional_count'] = this.numOfVacancy;
    data['open_job'] = this.openJob;
    data['resume'] = this.resume;
    data['company_count'] = this.companyCount;
    return data;
  }
}
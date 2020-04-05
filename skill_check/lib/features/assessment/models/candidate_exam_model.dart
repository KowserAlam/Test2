class CandidateExamModel {
  String regId;
  String candidateId;
  String candidateName;
  String examId;
  String examName;
  Duration examDuration;
  String status;
  String createdDate;

  CandidateExamModel(
      {this.candidateId,
        this.candidateName,
        this.examId,
        this.examName,
        this.examDuration,
        this.status,
        this.createdDate,this.regId});

  CandidateExamModel.fromJson(Map<String, dynamic> json) {
    candidateId = json['candidate_id'] ?? "";
    candidateName = json['candidate_name']?? "";
    examId = json['exam_id']?? "";
    examName = json['exam_name']?? "";
    examDuration = Duration(minutes: int.parse(json['duration_in_minutes']??"0"));
    status = json['status'] != null ? json['status'].toString():"";
    createdDate = json['created_date']?? "";
    regId = json['id'].toString()?? "";

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['candidate_id'] = this.candidateId;
    data['candidate_name'] = this.candidateName;
    data['exam_id'] = this.examId;
    data['exam_name'] = this.examName;
    data['duration_in_minutes'] = this.examDuration;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    data['id'] = this.regId;
    return data;
  }

  @override
  String toString() {
    return 'CandidateModel{candidateName: $candidateName}';
  }


}
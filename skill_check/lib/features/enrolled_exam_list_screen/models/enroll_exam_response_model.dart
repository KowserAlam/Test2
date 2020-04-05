class EnrollExamResponseModel {
  String status;
  int code;
  String message;
  Result result;

  EnrollExamResponseModel({this.status, this.code, this.message, this.result});
  EnrollExamResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  int regId;
  Result({this.regId});
  Result.fromJson(Map<String, dynamic> json) {
    regId = json['reg_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reg_id'] = this.regId;
    return data;
  }
}

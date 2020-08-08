import 'career_advice_model.dart';

class CareerAdviceScreenDataModel {
  String status;
  int count;
  bool nextPages;
  bool previousPages;
  int code;
  List<CareerAdviceModel> careerAdviceList;

  CareerAdviceScreenDataModel({
    this.status,
    this.count,
    this.nextPages,
    this.previousPages,
    this.code,
    this.careerAdviceList,
  });

  CareerAdviceScreenDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    nextPages = json['pages']["next_url"] != null ?? false;
    previousPages = json['previous_pages'];
    code = json['code'];
    if (json['results'] != null) {
      careerAdviceList = new List<CareerAdviceModel>();
      json['results'].forEach((v) {
        careerAdviceList.add(new CareerAdviceModel.fromJson(v));
      });
    }
  }
}

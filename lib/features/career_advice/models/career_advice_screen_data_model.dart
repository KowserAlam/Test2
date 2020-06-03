import 'career_advice_model.dart';

class CareerAdviceScreenDataModel {
  String status;
  int count;
  int startIndex;
  int endIndex;
  int numberOfPages;
  bool nextPages;
  bool previousPages;
  int previousPageNumber;
  int nextPageNumber;
  int code;
  Null currentUrl;
  List<CareerAdviceModel> results;

  CareerAdviceScreenDataModel(
      {this.status,
      this.count,
      this.startIndex,
      this.endIndex,
      this.numberOfPages,
      this.nextPages,
      this.previousPages,
      this.previousPageNumber,
      this.nextPageNumber,
      this.code,
      this.currentUrl,
      this.results});

  CareerAdviceScreenDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    startIndex = json['start_index'];
    endIndex = json['end_index'];
    numberOfPages = json['number_of_pages'];
    nextPages = json['next_pages'];
    previousPages = json['previous_pages'];
    previousPageNumber = json['previous_page_number'];
    nextPageNumber = json['next_page_number'];
    code = json['code'];
    currentUrl = json['current_url'];
    if (json['results'] != null) {
      results = new List<CareerAdviceModel>();
      json['results'].forEach((v) {
        results.add(new CareerAdviceModel.fromJson(v));
      });
    }
  }
}

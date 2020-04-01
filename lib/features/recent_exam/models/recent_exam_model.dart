import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/util/const.dart';
import 'package:p7app/main_app/util/json_keys.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';

class RecentExamModel {
  String image;

  String examName;

  DateTime examSubmittedDate;

  String resultStatus;

  int percentageOfCorrect;

  RecentExamModel(
      {this.image,
      this.examName,
      this.examSubmittedDate,
      this.resultStatus,
      this.percentageOfCorrect});

  factory RecentExamModel.fromJson(json) {

    var baseUrl = FlavorConfig?.instance?.values?.baseUrl ?? "";

    var image = json["exam"] != null
        ? (json['exam']['image'] != null? "$baseUrl${json['exam']['image']}" : kExamCoverImageNetwork)
        : kExamCoverImageNetwork;

    return RecentExamModel(
        image: "$image",
        examName: json['exam']['exam_name'] ?? "",
        examSubmittedDate: json['exam_submitted_date'] != null
            ? DateTime.parse(json['exam_submitted_date'])
            : DateTime.now(),
        resultStatus: json['result_status'] as String,
        percentageOfCorrect: json['percentage_of_correct'] as int);
  }

  Map<String, dynamic> toJson() => _$RecentExamModelToJson(this);

  Map<String, dynamic> _$RecentExamModelToJson(RecentExamModel instance) =>
      <String, dynamic>{
        'exam_thumb': instance.image,
        'exam_name': instance.examName,
        'exam_submitted_date': instance.examSubmittedDate.toIso8601String(),
        'result_status': instance.resultStatus,
        'percentage_of_correct': instance.percentageOfCorrect
      };

  @override
  String toString() {
    return 'RecentExam{examThumb: $image, examName: $examName, examSubmittedDate: $examSubmittedDate, resultStatus: $resultStatus, percentageOfCorrect: $percentageOfCorrect}';
  }
}

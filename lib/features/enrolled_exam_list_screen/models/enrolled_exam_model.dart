import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/util/const.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';

class EnrolledExamModel {
  int id;

  String examCode;

  String examName;

  Duration examDurationMinutes;

  String image;
  String instruction;

  EnrolledExamModel(
      {this.examCode,
      this.examName,
      this.examDurationMinutes,
      this.image,
      this.instruction,
      this.id});

  factory EnrolledExamModel.fromJson(json) {
    var baseUrl = FlavorConfig.instance.values.baseUrl;
    return EnrolledExamModel(
        examCode: json['exam_code'] as String,
        examName: json['exam_name'] as String,
        instruction: json['instruction'] as String,
        examDurationMinutes:
            Duration(minutes: int.parse(json['duration'] ?? 0)),
        image: json['image'] != null
            ? "$baseUrl${json['image']}"
            : kExamCoverImageNetwork,
        id: json['id'] as int);
  }

  Map<String, dynamic> toJson() => _$EnrolledExamModelToJson(this);

  Map<String, dynamic> _$EnrolledExamModelToJson(EnrolledExamModel instance) =>
      <String, dynamic>{
        'exam_code': instance.examCode,
        'exam_name': instance.examName,
        'duration': instance.examDurationMinutes.inMilliseconds,
        'instruction': instance.instruction,
        'image': instance.image,
        'id': instance.id
      };

  @override
  String toString() {
    return 'RegisteredExamModel{examCode: $examCode, examName: $examName, examDurationMinutes: $examDurationMinutes, examThumbnail: $image, examRegId: $id}';
  }
}

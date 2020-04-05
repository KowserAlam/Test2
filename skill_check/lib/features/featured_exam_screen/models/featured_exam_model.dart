import 'package:skill_check/main_app/flavour/flavour_config.dart';
import 'package:skill_check/main_app/util/const.dart';
import 'package:skill_check/main_app/api_helpers/urls.dart';

class FeaturedExamModel {
  int id;
  String examCode;
  String examName;
  Duration examDurationMinutes;
  String image;
  String examFee;
  String discountPrice;
  String discountPercent;
  String instruction;
  bool isEnrolled;

  FeaturedExamModel({
    this.examCode,
    this.examName,
    this.examDurationMinutes,
    this.image,
    this.examFee,
    this.instruction,
    this.discountPercent,
    this.discountPrice,
    this.isEnrolled,
    this.id,
  });

  factory FeaturedExamModel.fromJson(json) {
    var baseUrl = FlavorConfig?.instance?.values?.baseUrl??"";
    return FeaturedExamModel(
        examCode: json['exam_code'] as String,
        examName: json['exam_name'] as String,
        instruction: json['instruction'] as String,
        examDurationMinutes:
            Duration(minutes: int.parse(json['duration'] ?? 0)),
        image: json['image'] != null
            ? "$baseUrl${json['image']}"
            : kExamCoverImageNetwork,
        examFee: json['exam_fee']??"0",
        discountPercent: json['discount_percent'],
        discountPrice: json['discount_price'],
        isEnrolled: json['is_enrolled'] as bool ?? false,
        id: json['id'] as int);
  }

  Map<String, dynamic> toJson() => _$FeaturedExamModelToJson(this);

  Map<String, dynamic> _$FeaturedExamModelToJson(FeaturedExamModel instance) =>
      <String, dynamic>{
        'exam_code': instance.examCode,
        'exam_name': instance.examName,
        'duration': instance.examDurationMinutes,
        'image': instance.image,
        'id': instance.id,
        'exam_fee': instance.examFee,
        'discount_price': instance.discountPrice,
        'discount_percent': instance.discountPercent,
        'is_enrolled': instance.isEnrolled
      };
}

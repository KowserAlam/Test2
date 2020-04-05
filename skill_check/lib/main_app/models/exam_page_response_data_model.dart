import 'package:skill_check/features/featured_exam_screen/models/featured_exam_model.dart';

class ExamPageResponseDataModel<T> {
  List<T> examList;
  bool hasMoreData;

  ExamPageResponseDataModel({ this.examList, this.hasMoreData});
}

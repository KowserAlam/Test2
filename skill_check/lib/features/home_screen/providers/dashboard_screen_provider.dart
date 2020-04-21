import 'package:skill_check/features/assessment/models/candidate_exam_model.dart';
import 'package:skill_check/features/enrolled_exam_list_screen/repositories/self_enroll_exam_repository.dart';
import 'package:skill_check/features/home_screen/models/dashboard_models.dart';
import 'package:skill_check/features/enrolled_exam_list_screen/models/enrolled_exam_model.dart';
import 'package:skill_check/features/featured_exam_screen/models/featured_exam_model.dart';
import 'package:skill_check/features/home_screen/repositories/dashboard_repository.dart';
import 'package:skill_check/main_app/auth_service/auth_service.dart';
import 'package:skill_check/main_app/failure/failure.dart';
import 'package:skill_check/main_app/api_helpers/urls.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardScreenProvider with ChangeNotifier {
  DashBoardModel _dashBoardData;

  bool _isLoadingExam = false;
  bool _isFailedToLoad = false;

  bool get isFailedToLoad => _isFailedToLoad;

  set isFailedToLoad(bool value) {
    _isFailedToLoad = value;
    notifyListeners();
  }

  bool get isLoadingExam => _isLoadingExam;

  DashBoardModel get dashBoardData => _dashBoardData;

  set dashBoardData(DashBoardModel value) {
    _dashBoardData = value;
    notifyListeners();
  }

  set isLoadingExam(bool value) {
    _isLoadingExam = value;
    notifyListeners();
  }

  Future<Either<Failure, DashBoardModel>> fetchHomeScreenData() async {
    if (_isFailedToLoad) {
      isFailedToLoad = false;
    }

    var auth = await AuthService.getInstance();
//    print(auth.getUser().userId);

    Either<Failure, DashBoardModel> result = await DashBoardRepository()
        .getDashboardData(userId: auth.getUser().userId.toString());

    return result.fold(
      (exception) {
        isFailedToLoad = true;
        return result;
      },
      (data) {
        dashBoardData = data;
        return result;
      },
    );
  }

  /// User Events
  Future<bool> enrollExam({@required String examId, int index}) async {
    if (index != null) {
      _updateFeaturedExamModelState(index);
    }

    var auth = await AuthService.getInstance();

    var response = await SelfEnrollExamRepository()
        .sendEnrollRequest(examId: examId, userId: auth.getUser().userId);
    return response.fold((e) {
//      _updateFeaturedExamModelState(index, status: false);

      return false;
    }, (d) {
//      print(d.code);
      if (d.code == 200) {
        print(d.code);
        return true;
      } else {
//        _updateFeaturedExamModelState(index, status: false);
        return false;
      }
    });
  }

  _updateFeaturedExamModelState(int index, {bool status}) {
    _dashBoardData.featuredExam[index].isEnrolled = status ?? true;
    FeaturedExamModel featuredExamModel = _dashBoardData.featuredExam[index];
    _dashBoardData.enrolledExams.insert(
        0,
        EnrolledExamModel(
            image: featuredExamModel.image,
            examName: featuredExamModel.examName,
            examCode: featuredExamModel.examCode,
            examDurationMinutes: featuredExamModel.examDurationMinutes,
            skillId: featuredExamModel.skillId,
            instruction: featuredExamModel.instruction));
    notifyListeners();
  }

  resetState() {
    _dashBoardData = null;
    _isLoadingExam = false;
    _isFailedToLoad = false;
  }
}

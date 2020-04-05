import 'package:skill_check/features/assessment/models/questions_model.dart';
import 'package:skill_check/features/assessment/models/result_model.dart';
import 'package:skill_check/features/assessment/models/submit_asn_model.dart';
import 'package:skill_check/main_app/api_helpers/api_client.dart';
import 'package:skill_check/main_app/auth_service/auth_service.dart';
import 'package:skill_check/main_app/api_helpers/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'exam_provider.dart';

class SubmitProvider with ChangeNotifier {
  bool _isSubmitting = false;

  ResultModel _resultData;

  ResultModel get resultData => _resultData;

  set resultData(ResultModel value) {
    _resultData = value;
    notifyListeners();
  }

  bool get isSubmitting => _isSubmitting;

  set isSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }

  List<int> getSortedAnsListInInteger(QuestionModel data) {
    List<int> ansList = [];
    data.selectedAnswers.forEach((Answers ans) {
      ansList.add(int.parse(ans.id));
    });
    ansList.sort();
    return ansList;
  }

  Future<List<QuestionModel>> _getQuestionAnsList(context) async {
    return Provider.of<ExamProvider>(context,listen: false).questionList;
  }

  SubmitAnsModel getSubmitAnsModel(
      {@required String regId,
      @required List<QuestionModel> questionList,
      @required String userId}) {
    List<SubmitQuestionAnsModel> submitQuestionAnsModel = [];
    questionList.forEach((QuestionModel data) {
      List<int> ansListInInt = getSortedAnsListInInteger(data);
      String ansString = ansListInInt.join(',');
      data.selectedAnswers.map((Answers ans) => ans.id);
      submitQuestionAnsModel.add(
        SubmitQuestionAnsModel(
            questionIdId: data.id,
            questionText: data.question,
            submittedAnsId: ansString),
      );
    });

    SubmitAnsModel ans = SubmitAnsModel(
        examId: regId, questionAnsList: submitQuestionAnsModel, userId: userId);
    return ans;
  }

  sendPostRequestToServer(Map<String, dynamic> ansMap) async {
    var body = ansMap;

    return ApiClient().postRequest(Urls.submitUrl, body);

//    return await http
//        .post(Urls.submitUrl, body: json.encode(ansMap))
//        .timeout(Duration(seconds: 15));
  }

  Future<bool> handleSubmit(BuildContext context, String regId) async {
    var authUser = await AuthService.getInstance();
    var userId = authUser.getUser().userId;

    List<QuestionModel> questionList = await _getQuestionAnsList(context);
    SubmitAnsModel ans = getSubmitAnsModel(
        regId: regId, questionList: questionList, userId: userId);
    Map<String, dynamic> ansMap = ans.toJson();
    print(json.encode(ansMap));
    try {
      http.Response res = await sendPostRequestToServer(ansMap);
      print(res.statusCode);
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        print("receved body: ${res.body}");
        resultData = ResultModel.fromJson(data["result"]);
        print(resultData.numberOfQuestion);
        print("receved body: ${res.body}");
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }
}

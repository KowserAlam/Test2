import 'package:p7app/features/assessment/models/candidate_exam_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CandidateProvider with ChangeNotifier{

  List<CandidateExamModel> _candidateList = [];
  bool isLoading = false;

  List<CandidateExamModel> get candidateList => _candidateList;

  set candidateList(List<CandidateExamModel> value) {
    _candidateList = value;
    notifyListeners();
  }


  Future<List<CandidateExamModel>> fetchList(http.Client client) async{
    isLoading = true;
    print("Sending request");
    http.Response response = await ApiClient().getRequest(Urls.examListUrl);
//    http.Response response = await client.get(Urls.examListUrl);

    if(response.statusCode == 200){
      var data = json.decode(response.body);
      List<CandidateExamModel> list = [];
      data["registration"].forEach((item){
        list.add(CandidateExamModel.fromJson(item));
      });
      candidateList = list;
      isLoading = false;

      return candidateList;

    }else{
      isLoading = false;
      throw Exception('Failed to load list');

    }


  }


}
import 'dart:convert';

import 'package:p7app/features/home_screen/models/result_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ResultProvider with ChangeNotifier {
  bool _isBusy = false;
  Result _result;

  Result get result => _result??null;

  set result(Result value) {
    _result = value;
    notifyListeners();
  }

  bool get isBusy => _isBusy;

  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  fetResultData(String regId) async {
    isBusy = true;
    try {
//      var res = await http.get(Urls.examResultByIdUrl + "/$regId",);
    var url = Urls.examResultByIdUrl + "/$regId";
      var res = await  ApiClient().getRequest(url);
      print(res.body);

      var data = jsonDecode(res.body);
      if (data['result'] != null) {
        result = Result.fromJson(data['result']);
      }
      isBusy = false;
    } catch (e) {
      isBusy = false;
      print(e);
    }
  }
}

import 'package:assessment_ishraak/features/assessment/models/exam_center_model.dart';
import 'package:assessment_ishraak/main_app/api_helpers/urls.dart';
import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CenterLoginProvider with ChangeNotifier {
  bool _isObscurePassword = true;
  String _username = "";
  String _password = "";
  bool _isLoading = false;
  ExamCenterModel _examCenterModel;


  ExamCenterModel get examCenterUserModel => _examCenterModel;

  set examCenterUserModel(ExamCenterModel value) {
    _examCenterModel = value;
    notifyListeners();
  }

  bool get isObscurePassword => _isObscurePassword;

  set isObscurePassword(bool value) {
    _isObscurePassword = value;
  }

  bool get obscurePassword => _isObscurePassword;

  set obscurePassword(bool value) {
    _isObscurePassword = value;
    notifyListeners();
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

//  Future<Response> sendLoginRequestToServerWithDio() async {
//   try{
//       return await Dio().post(
//        ApiHelper.loginUrl,
//        data:
//        {
//          "username": username,
//          "password": password,
//        }
//        ,
//      ).then((Response response){
//        isLoading = false;
//        print(response.data['result']["user"]);
//        print(response.statusCode);
//        examCenterModel = ExamCenterModel(centerName: response.data['result']["user"]["username"]);
//        return response;
//      });
//
//    } on Exception catch (e){
//      isLoading = false;
//      print(e);
//      return null;
//    }
//
//  }

  Future<http.Response> sendHttpLoginRequestToServer(http.Client client) async {
    var body = json.encode({
      "username": username,
      "password": password,
    });

     http.Response response =  await client.post(Urls.loginUrl, body:body,);
//     http.Response response =  await client.get(ApiHelper.loginUrl,);

     if(response.statusCode == 200){
       var data = json.decode(response.body);
       isLoading = false;
       examCenterUserModel = ExamCenterModel(centerName: data['result']["user"]["username"]);
          return response;
     }else
       isLoading = false;
       throw Exception(StringUtils.somethingWentWrong);
  }

  Future<bool> handleLogin() async {
    isLoading = true;


    try{
      await sendHttpLoginRequestToServer(http.Client());
    }catch (e){
      isLoading = false;
      return false;
    }
    if(examCenterUserModel != null)
      {
//        print(examCenterUserModel.centerName);
        return true;
      }

    else
      return false;

  }


}

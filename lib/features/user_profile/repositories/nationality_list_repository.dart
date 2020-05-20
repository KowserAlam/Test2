import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:p7app/features/user_profile/models/nationality.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';

class NationalityListRepository{

  Future<Either<AppError,List<Nationality>>> getNationalityList() async{
    try{

      var res = await ApiClient().getRequest(Urls.nationalityListUrl);

      if(res.statusCode == 200){
        var decodedJson = json.decode(res.body);
        print(decodedJson);

        List<Nationality> list = fromJson(decodedJson);
        return Right(list);
      }else{
        return Left(AppError.unknownError);
      }



    }catch (e){
      print(e);

      return Left(AppError.serverError);
    }
  }
  List<Nationality> fromJson(json){
    List<Nationality> list = [];
//   List<Map<String,dynamic>> tl = json.cast<Map<String,dynamic>>();
//    tl.map<String>((e) => e['name']).toList();
    json.forEach((element) {
      list.add(Nationality.fromJson(element));
    });
    return list;
  }
}
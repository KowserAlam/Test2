import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:p7app/features/user_profile/models/institution.dart';
import 'package:p7app/features/user_profile/models/religion.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';

class InstitutionListRepository {
  var _cacheKey = "instituteList";

  Future<String> _getData()async{
    var cache = await Cache.load(_cacheKey);
    if(cache != null){
      return cache;
    }else{
      var res = await  ApiClient().getRequest(Urls.instituteListUrl);
      print(res.statusCode);
//      print(res.body);
      if(res.statusCode == 200){
        Cache.remember(_cacheKey, res.body,60*60);
        return res.body;
      }
      return res.body;
    }
  }

  Future<Either<AppError, List<Institution>>> getList() async {
    try {

//      var res = await  ApiClient().getRequest(Urls.instituteListUrl);
//      print(res.statusCode);
//      print(res.body);
    var body = await _getData();
        var decodedJson = json.decode(body);
//        print(decodedJson);
        List<Institution> list = fromJson(decodedJson);
        return Right(list);

    } catch (e) {
      print(e);

      return Left(AppError.serverError);
    }
  }

  List<Institution> fromJson(json) {
    List<Institution> list = [];
//   List<Map<String,dynamic>> tl = json.cast<Map<String,dynamic>>();
//    tl.map<String>((e) => e['name']).toList();
    json.forEach((element) {
      list.add(Institution.fromJson(element));
    });
    return list;
  }
}

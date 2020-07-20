import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';

class DegreeListRepository{
  var _cacheKey = "qualificationListUrl";

  Future<String> _getData() async {
    var cache = await Cache.load(_cacheKey);
    if (cache != null) {
      return cache;
    } else {
      var res = await ApiClient().getRequest(Urls.qualificationListUrl);
      print(res.statusCode);
//      print(res.body);
      if (res.statusCode == 200) {
        Cache.remember(_cacheKey, res.body, 60 * 60);
        return res.body;
      }
      return res.body;
    }
  }

  Future<List<String>>getList() async{
    try{
//      var res = await ApiClient().getRequest(Urls.qualificationListUrl);


        var decodedJson = json.decode(await _getData());
//        print(decodedJson);

        List<String> list = fromJson(decodedJson);
        return list;

    }catch (e){
      print(e);
      return [];
    }
  }

  List<String> fromJson(json){
   List<String> list = [];
   json.forEach((element) {
     list.add(element['name']);
   });
   return list;
  }
}
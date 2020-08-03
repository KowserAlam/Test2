import 'dart:convert';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';

class EducationLevelListRepository {
  var _cacheKey = Urls.educationLevelListURl;

  Future<String> _getData() async {
    var cache = await Cache.load(_cacheKey);
    if (cache != null) {
      return cache;
    } else {
      var res = await ApiClient().getRequest(Urls.educationLevelListURl);
      print(res.statusCode);
//      print(res.body);
      if (res.statusCode == 200) {
        Cache.remember(_cacheKey, res.body, 60 * 60);
        return res.body;
      }
      return res.body;
    }
  }

  Future<List<EducationLevel>> getList() async {
    try {
//      var res = await ApiClient().getRequest(Urls.qualificationListUrl);
      var decodedJson = json.decode(await _getData());
//        print(decodedJson);

      List<EducationLevel> list = _fromJson(decodedJson);
      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  List<EducationLevel> _fromJson(json) {
    List<EducationLevel> list = [];
    json.forEach((element) {
      list.add(element['name']);
    });
    return list;
  }

  Future<EducationLevel> getEducationLevelFromId(String id) async {
    return getList()
        .then((value) => value.firstWhere((element) => element.id == id))
        .catchError((err) {
          print(err);
          return null;
        });
  }
}

class EducationLevel {
  String id;
  String name;

  EducationLevel({this.id, this.name});

  factory EducationLevel.fromJson(Map<String, dynamic> json) {
    return EducationLevel(
      id: json["id"]?.toString(),
      name: json["name"],
    );
  }
//

}

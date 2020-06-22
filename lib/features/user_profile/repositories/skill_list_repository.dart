import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:p7app/features/user_profile/models/religion.dart';
import 'package:p7app/features/user_profile/models/skill.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/util/local_storage.dart';

class SkillListRepository {
  var _storageKey = "skillList";

  Future<Either<AppError, List<Skill>>> getSkillList() async {
    try {
      var res = await ApiClient().getRequest(Urls.skillListUrl);

      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        print(decodedJson);

        List<Skill> list = fromJson(decodedJson);
        _saveInLocalStorage(list);
        return Right(list);
      } else {
        return Left(AppError.unknownError);
      }
    } catch (e) {
      print(e);

      return Left(AppError.serverError);
    }
  }

  List<Skill> fromJson(json) {
    List<Skill> list = [];
//   List<Map<String,dynamic>> tl = json.cast<Map<String,dynamic>>();
//    tl.map<String>((e) => e['name']).toList();
    json.forEach((element) {
      list.add(Skill.fromJson(element));
    });
    list.sort((a, b) => a.name.compareTo(b.name));

    return list;
  }

  _saveInLocalStorage(List<Skill> list) async {
    var storage = await LocalStorageService.getInstance();
    var data = {"fetchAt": DateTime.now(), "data": list.map((e) => e.toJson())};
    storage.saveString(_storageKey, json.encode(data));
  }

  Future<List<Skill>> _getFromLocalStorage() async {
    var storage = await LocalStorageService.getInstance();
    var data = storage.getString(_storageKey);
    var decodedData = json.decode(data);
    return fromJson(decodedData);
  }
}

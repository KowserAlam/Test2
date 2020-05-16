import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:p7app/features/user_profile/models/religion.dart';
import 'package:p7app/features/user_profile/models/skill.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/error.dart';

class SkillListRepository{

  Future<Either<AppError,List<Skill>>> getSkillList() async{
    try{

      var res = await ApiClient().getRequest(Urls.skillListUrl);

      if(res.statusCode == 200){
        var decodedJson = json.decode(res.body);
        print(decodedJson);

        List<Skill> list = fromJson(decodedJson);
        return Right(list);
      }else{
        return Left(AppError.unknownError);
      }

    }catch (e){
      print(e);

      return Left(AppError.serverError);
    }
  }
  List<Skill> fromJson(json){
    List<Skill> list = [];
//   List<Map<String,dynamic>> tl = json.cast<Map<String,dynamic>>();
//    tl.map<String>((e) => e['name']).toList();
    json.forEach((element) {
      list.add(Skill.fromJson(element));
    });
    list.sort((a,b)=>a.name.compareTo(b.name));

    return list;
  }
}
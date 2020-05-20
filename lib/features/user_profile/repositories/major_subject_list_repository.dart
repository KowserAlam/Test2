import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:p7app/features/user_profile/models/institution.dart';
import 'package:p7app/features/user_profile/models/major.dart';
import 'package:p7app/features/user_profile/models/religion.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';

class MajorSubListListRepository {
  Future<Either<AppError, List<MajorSubject>>> getList() async {
    try {
      var res = await ApiClient().getRequest(Urls.majorListUrl);

      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        print(decodedJson);

        List<MajorSubject> list = fromJson(decodedJson);
        return Right(list);
      } else {
        return Left(AppError.unknownError);
      }
    } catch (e) {
      print(e);

      return Left(AppError.serverError);
    }
  }

  List<MajorSubject> fromJson(json) {
    List<MajorSubject> list = [];
//   List<Map<String,dynamic>> tl = json.cast<Map<String,dynamic>>();
//    tl.map<String>((e) => e['name']).toList();
    json.forEach((element) {
      list.add(MajorSubject.fromJson(element));
    });
    return list;
  }
}

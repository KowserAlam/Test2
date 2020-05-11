import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/error.dart';

class PopularJobCategoriesLisRepository{

  Future<Either<AppError,List<String>>> getList() async{
    try{
      var res = await ApiClient().getRequest(Urls.popularJobCategoriesListUrl);

      if(res.statusCode == 200){
        var decodedJson = json.decode(res.body);
        print(decodedJson);

        List<String> list = fromJson(decodedJson);
        return Right(list);
      }else{
        return Left(AppError.unknownError);
      }
    }catch (e){
      print(e);
      return Left(AppError.serverError);
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
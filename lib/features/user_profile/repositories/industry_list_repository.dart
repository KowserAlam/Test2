import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/error.dart';

class IndustryListRepository{

  Future<Either<AppError,List<String>>> getIndustryList() async{
    try{

      var res = await ApiClient().getRequest(Urls.industryListUrl);
      var decodedJson = json.decode(res.body);
      print(decodedJson);

      List<String> list = decodedJson.map((v)=>v["name"] as String ).toList();
      return Right(list);

    }catch (e){
      print(e);
      return Left(AppError.serverError);
    }
  }
}
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/error.dart';

class IndustryListRepository{

  Future<Either<AppError,String>> getIndustryList() async{
    try{

      var res = await ApiClient().getRequest(Urls.industryListUrl);
      var list = json
      Right();

    }catch (e){
      return Left(AppError.serverError);
    }
  }
}


import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:p7app/features/user_profile/models/company.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/error.dart';

class CompanyListRepository{


  Future<Either<AppError,List<Company>>> getList({String query}) async{
    try{

      var url = "${Urls.companySearchUrl}/?name=$query";
      debugPrint(url);
      var res = await ApiClient().getRequest(url);

      if(res.statusCode == 200){
        var decodedJson = json.decode(res.body);
        debugPrint(decodedJson.toString());
        List<Company> list = fromJson(decodedJson);
        return Right(list);
      }else{
        return Left(AppError.unknownError);
      }

    }
    on SocketException catch (e){
      print(e);
      return Left(AppError.networkError);
    }
    catch (e){
      print(e);
      return Left(AppError.unknownError);
    }
  }

  List<Company> fromJson(json){
    List<Company> list = [];

    if(json['data'] != null){
      json['data'].forEach((element) {
        list.add(Company.fromJson(element));
      });
    }

//   List<Map<String,dynamic>> tl = json.cast<Map<String,dynamic>>();
//    tl.map<String>((e) => e['name']).toList();

    return list;
  }

}
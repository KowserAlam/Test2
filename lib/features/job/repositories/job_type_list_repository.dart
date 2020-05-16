import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:p7app/features/job/models/jon_type_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/error.dart';

class JobTypeListRepository{

  Future<Either<AppError,List<JobType>>> getList() async{
    try{
      var res = await ApiClient().getRequest(Urls.jobTypeListUrl);

      if(res.statusCode == 200){
        var decodedJson = json.decode(res.body);
        print(decodedJson);

        List<JobType> list = fromJson(decodedJson);
        return Right(list);
      }else{
        return Left(AppError.unknownError);
      }
    }catch (e){
      print(e);
      return Left(AppError.serverError);
    }
  }

  List<JobType> fromJson(json){
   List<JobType> list = [];
   json.forEach((element) {
     list.add(JobType.fromJson(element));
   });
   return list;
  }
}
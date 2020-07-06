import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:p7app/features/company/models/company.dart';
import 'package:p7app/features/company/models/company_screen_data_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';

class CompanyListRepository {
  Future<Either<AppError, CompanyScreenDataModel>> getList(
      {String query, int pageSize = 10, int page = 1}) async {
    try {
      var url =
          "${Urls.companySearchUrl}/?page_size=$pageSize&name=${query ?? ""}&page=${page}";
      debugPrint(url);
      var res = await ApiClient().getRequest(url);
      debugPrint(res.statusCode.toString());
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        Logger().i(decodedJson);
        CompanyScreenDataModel data =
            CompanyScreenDataModel.fromJson(decodedJson);
        return Right(data);
      } else {
        return Left(AppError.serverError);
      }
    } on SocketException catch (e) {
      print(e);
      BotToast.showText(text: StringResources.unableToReachServerMessage);
      return Left(AppError.networkError);
    } catch (e) {
      print(e);
      return Left(AppError.unknownError);
    }
  }

  List<Company> fromJson(json) {
    List<Company> list = [];

    if (json != null) {
      json.forEach((element) {
        list.add(Company.fromJson(element));
      });
    }

//   List<Map<String,dynamic>> tl = json.cast<Map<String,dynamic>>();
//    tl.map<String>((e) => e['name']).toList();

    return list;
  }

  Future<Company> getCompanyDetails(String name) async {
    var result = await getList(query: name);
    return result.fold((l) {
      print(l);
      return null;
    }, (CompanyScreenDataModel data) {
      var companyList = data.companies;
      print(companyList);
      if (companyList.length > 0) {
        if (companyList.first.name == name) {
          return companyList.first;
        } else {
          return null;
        }
      }
      return null;
    });
  }
}

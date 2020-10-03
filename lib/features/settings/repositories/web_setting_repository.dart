import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/models/web_settings_model.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class WebSettingsRepository {
  Future<Either<AppError, WebSettingsModel>> getSettingInfo(
      {ApiClient apiClient}) async {
    var client = apiClient ?? ApiClient();

    try{
      var res = await client.getRequest(Urls.settingsUrl);
      logger.i(res.statusCode);
      logger.i(res.body);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        var data = WebSettingsModel.fromJson(decodedJson[0]);
        return Right(data);
      } else {
        return Left(AppError.httpError);
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
}

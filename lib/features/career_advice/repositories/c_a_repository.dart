import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:p7app/features/career_advice/models/career_advice_screen_data_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class CareerAdviceRepository {
  Future<Either<AppError, CareerAdviceScreenDataModel>> getData(
      {int page = 1, int pageSize = 6, ApiClient apiClient}) async {
    try {
//      dev.ishraak.com/api/career_advise/?page_size=2&page=1
      var url = "${Urls.careerAdviceUrl}/?page_size=${pageSize}&page=${page}";
      var client = apiClient ?? ApiClient();
      var res = await client.getRequest(url);
//      logger.i(res.statusCode);

      if (res.statusCode == 200) {
        var decodedJson = json.decode(utf8.decode(res.bodyBytes));
//        logger.i({"CareerAdviceRepository": decodedJson});
        return Right(CareerAdviceScreenDataModel.fromJson(decodedJson));
      } else {
        logger.e({"statusCode": res.statusCode, "body": res.body});
        return Left(AppError.httpError);
      }
    } on SocketException catch (e) {
      logger.e(e);
      return Left(AppError.networkError);
    } catch (e) {
      logger.e(e);
      return Left(AppError.unknownError);
    }
  }
}

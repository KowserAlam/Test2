import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:p7app/features/notification/repositories/notification_screen_data_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class NotificationRepository {
  Future<Either<AppError, NotificationScreenDataModel>>
      getNotificationsList({int page}) async {
    // try {
      var url = "${Urls.notificationListUrl}?page=${page??1}";
      var response = await ApiClient().getRequest(url);
      logger.i(response.statusCode);
      // logger.i(response.body);
      if (response.statusCode == 200) {
        var mapData = json.decode(utf8.decode(response.bodyBytes));
        // logger.i(mapData);
        var data = NotificationScreenDataModel.fromJson(mapData);
        return Right(data);
      } else if (response.statusCode == 401) {
        BotToast.showText(text: StringResources.unauthorizedText);
        return Left(AppError.unauthorized);
      } else {
        BotToast.showText(text: StringResources.somethingIsWrong);
        return Left(AppError.unknownError);
      }
    // } on SocketException catch (e) {
    //   logger.e(e);
    //   BotToast.showText(text: StringResources.unableToReachServerMessage);
    //   return Left(AppError.networkError);
    // } catch (e) {
    //   logger.e(e);
    //   BotToast.showText(text: StringResources.somethingIsWrong);
    //   return Left(AppError.serverError);
    // }
  }

  Future<bool> markAsRead(int id) async {
    var url = "${Urls.notificationMarkReadUrl}/${id}/";

//    logger.i(url);
    try {
      var res = await ApiClient().putRequest(
        url,
        {'is_read': 1},
      );
      logger.i(res.statusCode);
      logger.i(res.body);
      if (res.statusCode == 200) {
        return true;
      } else {}
      return false;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:p7app/features/notification/repositories/notification_screen_data_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

class NotificationRepository {
  Future<Either<AppError, NotificationScreenDataModel>>
      getNotificationsList() async {
    try {
      var response = await ApiClient().getRequest(Urls.notificationListUrl);
      print(response.statusCode);
//      print(response.body);
      if (response.statusCode == 200) {
        var mapData = json.decode(utf8.decode(response.bodyBytes));

        var data = NotificationScreenDataModel.fromJson(mapData);
        return Right(data);
      } else if (response.statusCode == 401) {
        BotToast.showText(text: StringUtils.unauthorizedText);
        return Left(AppError.unauthorized);
      } else {
        BotToast.showText(text: StringUtils.somethingIsWrong);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      print(e);
      BotToast.showText(text: StringUtils.unableToReachServerMessage);
      return Left(AppError.networkError);
    } catch (e) {
      print(e);
      BotToast.showText(text: StringUtils.somethingIsWrong);
      return Left(AppError.serverError);
    }
  }

  Future<bool> markAsRead(int id) async {

    var url = "${Urls.notificationMarkReadUrl}/${id}/";

//    print(url);
    try {
      var res = await ApiClient().putRequest(
        url,
        {'is_read': 1},
      );
      print(res.statusCode);
      print(res.body);
      if (res.statusCode == 200) {
        return true;
      } else {}
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

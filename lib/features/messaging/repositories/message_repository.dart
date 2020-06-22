
import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:p7app/features/messaging/model/message_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';

class MessageRepository{
  Future<Either<AppError,MessageScreenDataModel>> getMessageList() async {
    try {
      var response = await ApiClient().getRequest(Urls.messageListUrl);
      print(response.statusCode);
//      print(response.body);
      if (response.statusCode == 200) {
        var mapData = json.decode(utf8.decode(response.bodyBytes));

        var data = MessageScreenDataModel.fromJson(mapData);
        return Right(data);
      } else if (response.statusCode == 401) {
        BotToast.showText(text: StringResources.unauthorizedText);
        return Left(AppError.unauthorized);
      } else {
        BotToast.showText(text: StringResources.somethingIsWrong);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      print(e);
      BotToast.showText(text: StringResources.unableToReachServerMessage);
      return Left(AppError.networkError);
    } catch (e) {
      print(e);
      BotToast.showText(text: StringResources.somethingIsWrong);
      return Left(AppError.serverError);
    }
  }

  Future<bool> markAsRead(int id) async {

    var url = "${Urls.messageMarkedReadUrl}/${id}/";

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
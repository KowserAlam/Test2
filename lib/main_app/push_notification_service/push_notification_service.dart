import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/route_manager.dart';
import 'package:p7app/features/notification/views/notification_screen.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/repositories/app_info_repository.dart';
import 'package:p7app/main_app/util/device_info_util.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  initPush() {
    if (!kIsWeb) if (Platform.isAndroid || Platform.isIOS) {
      _init();

    } else {
      logger.e(
          "Notification service not implemented for ${Platform.operatingSystem}!");
    }
  }

  void fcmSubscribeNews() {
    if (!kIsWeb) if (Platform.isAndroid || Platform.isIOS) {
      if (FlavorConfig.isDevelopment()) {
        _firebaseMessaging.subscribeToTopic('news_dev');
      } else {
        _firebaseMessaging.subscribeToTopic('news');
      }

      debugPrint("subscribeToTopic - news");
    } else {
      logger.e(
          "Notification service not implemented for ${Platform.operatingSystem}!");
    }
  }

  void fcmUnSubscribeNews() {
    if (FlavorConfig.isDevelopment()) {
      _firebaseMessaging.unsubscribeFromTopic('news_dev');
    }else{
      _firebaseMessaging.unsubscribeFromTopic('news');
    }

    debugPrint("unsubscribeFromTopic - news");
  }

  _init() async {
    bool isLoggedIn = await AuthService.getInstance().then((value) => value.isAccessTokenValid());
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.onIosSettingsRegistered.listen((d) {
      print(d);
    });
    if (await locator<SettingsViewModel>().getNewsPushStatus()) {}

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        BotToast.showSimpleNotification(
          title: message['notification']['title'],
          subTitle: message['notification']['body'],
          duration: Duration(seconds: 2),
        );

//        if (_currentActiveChat != message["data"]["chatId"]) {}

        return;
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onResume: $message");

        return;
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");

        if(isLoggedIn){
          Get.to(NotificationScreen());
        }

        return;
      },
    );
  }

  Future<String> getToken() async {
    var token = await _firebaseMessaging.getToken();
    debugPrint("FCMT Token: $token");
    return token;
  }


  updateTokenInServer()async{
    Map<String,dynamic> info = await DeviceInfoUtil().getDeviceInfo();
    var info2 = {
      "app_version": await AppInfoRepository().getAppVersion(),
      "fcm_token": await getToken(),
    };
    info.addAll(info2);
    //TODO: have to add url
    var url = Urls.fcmTokenAddUrl;
    logger.i(info);
    var res = await ApiClient().postRequest(url, info);
    logger.i(res.statusCode);
    logger.i(res.body);
  }
}

import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/util/logger_helper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  initPush() {
    if (!kIsWeb) if (Platform.isAndroid || Platform.isIOS) {
      _init();
      getToken();
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

        return;
      },
    );
  }

  Future<String> getToken() async {
    var token = await _firebaseMessaging.getToken();
    debugPrint("FCMT Token: $token");
    return token;
  }
}

import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  initPush(){

      _init();
      getToken();
  }



  void fcmSubscribeNews() {
    _firebaseMessaging.subscribeToTopic('news');
    debugPrint("subscribeToTopic - news");
  }

  void fcmUnSubscribeNews() {
    _firebaseMessaging.unsubscribeFromTopic('news');
    debugPrint("unsubscribeFromTopic - news");
  }

  _init() async {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.onIosSettingsRegistered.listen((d) {
      print(d);
    });
    if (await locator<SettingsViewModel>().getNewsPushStatus()) {
      fcmSubscribeNews();
    }

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

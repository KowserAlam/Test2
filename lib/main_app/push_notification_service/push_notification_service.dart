
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class PushNotificationService{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  PushNotificationService(){

    if(Platform.isAndroid || Platform.isIOS){
      _init();
      getToken();
    }else{
      Logger().i("Notification service not implemented for ${Platform.operatingSystem}!");
    }

  }

  void fcmSubscribe() {
    _firebaseMessaging.subscribeToTopic('news');

  }

  void fcmUnSubscribe() {
    _firebaseMessaging.unsubscribeFromTopic('news');
  }

  _init() async{
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.onIosSettingsRegistered.listen((d) {
      print(d);
    });
    fcmSubscribe();
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

  Future<String> getToken()async{
    var token = await     _firebaseMessaging.getToken();
    debugPrint("FCMT Token: $token");
    return token;
  }
}
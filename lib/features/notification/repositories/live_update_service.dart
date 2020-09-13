import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/notification/models/notification_model.dart';
import 'package:p7app/features/notification/views/notification_screen.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/util/logger_helper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io/socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LiveUpdateService {
  var notificationUpdate = PublishSubject<NotificationModel>();

  initSocket(BuildContext context) async {
    logger.i("initSocket");
    var token = await AuthService.getInstance()
        .then((value) => value.getUser().accessToken);
    var url = "https://iss.ishraak.com?token=$token";
    logger.i(url);
    // Dart client
    IO.Socket socket = IO.io(url, {
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.on('connect', (_) {
      logger.i('connect');
//      socket.emit('receive', 'test');
    });
    socket.on('event', (data) => logger.i(data));
    socket.on('disconnect', (_) => logger.i('disconnect'));
    socket.on('receive', (d) {
      var data = json.decode(d);
      logger.i(data);
      if (data['type'] == "notification") {
        logger.i("notification");
        var notificationMap = json.decode(data["text"]);
        logger.i(notificationMap);
        var notification = NotificationModel.fromJson(notificationMap);
        notificationUpdate.sink.add(notification);
        _showInAppNotification(context, notification);
      }
    });
   socket.connect();
  }

  _showInAppNotification(context, NotificationModel notification) {
    // BotToast.showNotification(
    //     title: (_) => Text(notification?.title ?? ""),
    //     subtitle: (_) => Text(notification?.message ?? ""),
    //     onTap: () {
    //       Navigator.push(context,
    //           CupertinoPageRoute(builder: (context) => NotificationScreen()));
    //     },onClose: (){
    //       BotToast.cleanAll();
    // });

    BotToast.showSimpleNotification(
      title: notification?.title ?? "",
      subTitle: notification?.message ?? "",
        onTap: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => NotificationScreen()));
        },onClose: (){
      BotToast.cleanAll();
    });
  }

  dispose() {
    notificationUpdate.close();
  }
}

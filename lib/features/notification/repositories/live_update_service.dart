import 'dart:convert';

import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/util/logger_helper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io/socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LiveUpdateService {
  var _notification = PublishSubject();
  initSocket() async {
//    logger.i("initSocket");
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
    socket.on('receive', ( d) {
      var data = json.decode(d);
      print(data);
      if(data['type']=="notification"){
        print("Notification");
      }
    });
//    socket.connect();
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';



class TokenRefreshScheduler {
  static TokenRefreshScheduler _instance;
  Timer _timer;
  bool _started = false;

  static getInstance() {
    return _instance ?? TokenRefreshScheduler._internal();
  }

  TokenRefreshScheduler._internal(){


    if(!_started)
    _watchAccessTokenRefresh();
  }


  _watchAccessTokenRefresh() async {

    var authService = await AuthService.getInstance();
    var interval = authService.getRefreshInterval();
    if (interval != null) {
      if (interval > Duration.zero) {
        _started = true;
        debugPrint("Watching for token refresh !");
        Timer.periodic(interval, (timer) {
          authService.refreshToken().then((value) {
            if (value) {
              debugPrint("Token Refreshed");
            } else {
              debugPrint("Unable to Refreshed");
            }
          });
        });

      }
    }
  }
}

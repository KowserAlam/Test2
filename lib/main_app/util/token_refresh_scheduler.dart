import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';



class TokenRefreshScheduler {
  static TokenRefreshScheduler _instance;
  Timer _timer;

  static getInstance() {
    return _instance ?? TokenRefreshScheduler._internal();
  }

  TokenRefreshScheduler._internal(){
    _watchAccessTokenRefresh();
  }


  _watchAccessTokenRefresh() async {
    var authService = await AuthService.getInstance();
    var interval = authService.getRefreshInterval();
    if (interval != null) {
      if (interval > Duration.zero) {
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

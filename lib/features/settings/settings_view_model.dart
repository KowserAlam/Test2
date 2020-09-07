import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/push_notification_service/push_notification_service.dart';

//import 'package:cached_network_image/';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:p7app/main_app/util/local_storage.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/views/widgets/restart_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class SettingsViewModel with ChangeNotifier {
  String _isEnabledNewsPushKey = "isEnabledNewsPush";
  bool isEnabledNewsPush =false;

  SettingsViewModel() {
//    initPref();
    initSettings();
  }

  initSettings() {
    Future.wait([
      getNewsPushStatus(),
    ]).then((value) {notifyListeners();});
  }

  initPref() async {
    var preferences = await SharedPreferences.getInstance();
    isDarkModeOn = preferences.getBool(StringResources.isDarkModeOn) ?? false;
  }

  bool _isDarkModeOn = false;

  bool get isDarkModeOn => _isDarkModeOn;

  set isDarkModeOn(bool value) {
    _isDarkModeOn = value;
    notifyListeners();
  }

  void toggleThemeChangeEvent() async {
    isDarkModeOn = !isDarkModeOn;
    var preferences = await SharedPreferences.getInstance();
    preferences.setBool(StringResources.isDarkModeOn, isDarkModeOn);
  }

  Future<void> clearAllCachedData() async {
    return DefaultCacheManager().emptyCache();
  }

  togglePushNotificationNewUpdate({Key key}) async {
    isEnabledNewsPush = !isEnabledNewsPush;
    var storage = await LocalStorageService.getInstance();
   var pushService =  locator<PushNotificationService>();
    if(isEnabledNewsPush){
      pushService.fcmSubscribeNews();
    }else{
      pushService.fcmUnSubscribeNews();
    }
    storage.saveBool(_isEnabledNewsPushKey, isEnabledNewsPush);
    notifyListeners();
  }

  Future<bool> getNewsPushStatus() async {
    var storage = await LocalStorageService.getInstance();
    var val = storage.getBool(_isEnabledNewsPushKey) ?? true;
    isEnabledNewsPush = val;
    return val;
  }

  signOut() {
    AuthService.getInstance().then((value) => value.removeUser()).then((value) {
      clearAllCachedData();
//      Cache.clear();
      locator<RestartNotifier>().restartApp();
    });
  }
}

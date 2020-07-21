
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
//import 'package:cached_network_image/';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class SettingsViewModel with ChangeNotifier {
  SettingsViewModel() {
    initPref();
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

  void toggleThemeChangeEvent() async{
    isDarkModeOn =  !isDarkModeOn;
    var preferences = await SharedPreferences.getInstance();
    preferences.setBool(StringResources.isDarkModeOn, isDarkModeOn);
  }

  Future<void> clearAllCachedData()async{


    return DefaultCacheManager().emptyCache();
  }

}

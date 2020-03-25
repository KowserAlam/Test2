
import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigProvider with ChangeNotifier {
  ConfigProvider() {
    initPref();
  }


  initPref() async {
    var preferences = await SharedPreferences.getInstance();
    isDarkModeOn = preferences.getBool(StringUtils.isDarkModeOn) ?? false;
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
    preferences.setBool(StringUtils.isDarkModeOn, isDarkModeOn);
  }
}

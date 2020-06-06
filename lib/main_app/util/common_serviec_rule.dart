import 'package:get_it/get_it.dart';
import 'package:p7app/main_app/resource/const.dart';

class CommonServiceRule {
  static CommonServiceRule _instance = CommonServiceRule._internal();
  static Duration _onLoadPageReloadTime;

  CommonServiceRule._internal();

  factory CommonServiceRule(
      {onLoadPageReloadTime = kDefaultTimeToPreventAutoRefresh}) {
    _onLoadPageReloadTime = onLoadPageReloadTime;
    return _instance;
  }

  static CommonServiceRule get instance {
    return _instance;
  }

  static Duration get onLoadPageReloadTime => _onLoadPageReloadTime;

  static set onLoadPageReloadTime(Duration value) {
    _onLoadPageReloadTime = value;
  }
}

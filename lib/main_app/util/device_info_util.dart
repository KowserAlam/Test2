import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class DeviceInfoUtil {
  DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String> getDeviceID() async {
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      logger.i({
        "device_id": iosInfo.identifierForVendor,
        "device_os_version": iosInfo.systemVersion,
        "device_brand": iosInfo.name,
        "device_model": iosInfo.model,
        "iosInfo.systemName": iosInfo.systemName,
      });
      // logger.i('Running on ${iosInfo.utsname.machine}');

      return iosInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      logger.i({
        "device_id": androidInfo.androidId,
        "device_brand": androidInfo.brand,
        "device_model": androidInfo.model,
        "device_os_version": androidInfo.version.release,
      });
      // logger.i('Running on ${androidInfo.device}');  // e.g. "Moto G (4)"

      return androidInfo.androidId;
    } else {
      return "12321abc";
    }
  }
  Future<Map<String,dynamic>> getDeviceInfo() async {
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      var info = {
        "device_id": iosInfo.identifierForVendor,
        "device_os_version": iosInfo.systemVersion,
        "device_brand": iosInfo.model,
        "device_model": iosInfo.name,
        "device_os_type": iosInfo.systemName,

      };
      // logger.i('Running on ${iosInfo.utsname.machine}');
      logger.i(info);
      return info;

    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      var info = {
        "device_id": androidInfo.androidId,
        "device_brand": androidInfo.brand,
        "device_model": androidInfo.model,
        "device_os_version": androidInfo.version.release,
      };
     logger.i(info);

      return info;
    } else {
      var info = {
        "device_id": Platform.localHostname,
        "device_brand": Platform.operatingSystem,
        "device_model": Platform.operatingSystem,
        "device_os_version": Platform.operatingSystemVersion,
        "version": Platform.version,
      };
      logger.i(info);
      return info;
    }
  }
}

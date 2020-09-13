import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:p7app/main_app/util/logger_helper.dart';
class DeviceInfoUtil{

  DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String>getDeviceID()async{
   if( Platform.isIOS){
     IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;

     logger.i('${iosInfo.utsname.machine}');
     logger.i('Running on ${iosInfo.utsname.machine}');
     return iosInfo.identifierForVendor;
   }else if(Platform.isAndroid){
     AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
     logger.i(androidInfo.id);
     logger.i('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"

     return androidInfo.id;
   }else{
     return "12321abc";
   }


  }
  }

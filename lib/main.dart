import 'package:flutter/services.dart';
import 'package:p7app/features/config/config_provider.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/p7_app.dart';
import 'package:device_preview/device_preview.dart' as DP;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_app/flavour/flavour_config.dart';

///device preview should be disable before generate apk
bool isEnabledDevicePreview = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FlavorConfig(
      flavor: Flavor.DEV,
      color: Colors.deepPurpleAccent,
      values: FlavorValues(
          baseUrl: kBaseUrDev));

  runApp(
    ChangeNotifierProvider(
      create: (context) => ConfigProvider(),
      child: isEnabledDevicePreview? DP.DevicePreview(
        builder: (context) => P7App(),
      ):P7App(
        isEnabledDevicePreview: isEnabledDevicePreview,
      ),
    ),
  );


}


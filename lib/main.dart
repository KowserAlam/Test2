import 'package:assessment_ishraak/features/config/config_provider.dart';
import 'package:assessment_ishraak/main_app/api_helpers/urls.dart';
import 'package:assessment_ishraak/main_app/project_seven_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_app/flavour/flavour_config.dart';

///device preview should be disable before generate apk
bool isEnabledDevicePreview = false;

void main() async {
  FlavorConfig(
      flavor: Flavor.DEV,
      color: Colors.deepPurpleAccent,
      values: FlavorValues(
          baseUrl: kBaseUrDev));

  runApp(
    ChangeNotifierProvider(
      create: (context) => ConfigProvider(),
      child: isEnabledDevicePreview? DevicePreview(
        builder: (context) => ProjectSevenMaterialApp(),
      ):ProjectSevenMaterialApp(
        isEnabledDevicePreview: isEnabledDevicePreview,
      ),
    ),
  );

}

import 'package:p7app/features/config/config_provider.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/p7_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_app/flavour/flavour_config.dart';

///device preview should be disable before generate apk
bool isEnabledDevicePreview = false;

void main() async {
  FlavorConfig(
    flavor: Flavor.PRODUCTION,
    color: Colors.deepPurpleAccent,
    values: FlavorValues(baseUrl: kBaseUrlProd),
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ConfigProvider(),
      child: isEnabledDevicePreview
          ? DevicePreview(
              builder: (context) => P7App(),
            )
          : P7App(
              isEnabledDevicePreview: isEnabledDevicePreview,
            ),
    ),
  );
}

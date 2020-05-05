import 'package:flutter/services.dart';
import 'package:p7app/features/config/config_provider.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/p7_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_app/flavour/flavour_config.dart';

///device preview should be disable before generate apk
bool isEnabledDevicePreview = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  FlavorConfig(
    flavor: Flavor.PRODUCTION,
    color: Colors.deepPurpleAccent,
    values: FlavorValues(baseUrl: kBaseUrlProd),
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ConfigProvider(),
      child: P7App(),
    ),
  );
}

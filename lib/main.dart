import 'package:flutter/services.dart';
import 'package:p7app/features/config/config_provider.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/p7_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_app/service_locator/locator.dart';

import 'main_app/flavour/flavour_config.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupLocator();
  FlavorConfig(
      flavor: Flavor.DEV,
      color: Colors.deepPurpleAccent,
      values: FlavorValues(
          baseUrl: kBaseUrDev));

  runApp(
    ChangeNotifierProvider(
      create: (context) => ConfigProvider(),
      child:P7App(),
    ),
  );


}


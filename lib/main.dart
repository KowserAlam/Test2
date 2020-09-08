import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/p7_app.dart';
import 'package:p7app/main_app/views/widgets/restart_widget.dart';

import 'main_app/flavour/flavour_config.dart';
import 'main_app/util/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupLocator();
  FlavorConfig(
      flavor: Flavor.DEV,
      color: Colors.deepPurpleAccent,
      values: FlavorValues(baseUrl: kBaseUrDev));
  runApp(
    P7App(),
  );
}
 
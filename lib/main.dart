import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/p7_app.dart';
import 'package:p7app/main_app/views/widgets/restart_widget.dart';

import 'main_app/flavour/flavour_config.dart';
import 'main_app/util/locator.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  // user trust SSL certificate for iss.ishraak.com socket server
  await _loadCertificate();
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
Future _loadCertificate() async {
  ByteData data =
  await rootBundle.load('assets/certification/iss-ishraak-com-chain.pem');
  SecurityContext context = SecurityContext.defaultContext;
  return context.setTrustedCertificatesBytes(data.buffer.asUint8List());
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/p7_app.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/views/widgets/restart_widget.dart';
import 'package:provider/provider.dart';

import 'main_app/flavour/flavour_config.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  // user trust SSL certificate for jobxprss.com
  await _loadCertificate();

  setupLocator();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FlavorConfig(
    flavor: Flavor.PRODUCTION,
    color: Colors.deepPurpleAccent,
    values: FlavorValues(baseUrl: kBaseUrlProd),
  );
  runApp(
    P7App(),
  );
}

Future _loadCertificate() async {
  ByteData data =
      await rootBundle.load('assets/certification/jobxprss-com-chain.pem');
  SecurityContext context = SecurityContext.defaultContext;
  ByteData data2 =
  await rootBundle.load('assets/certification/iss-ishraak-com-chain.pem');
  SecurityContext context2 = SecurityContext.defaultContext;
   context2.setTrustedCertificatesBytes(data2.buffer.asUint8List());
  return context.setTrustedCertificatesBytes(data.buffer.asUint8List());
}

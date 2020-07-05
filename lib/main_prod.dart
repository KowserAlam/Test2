import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:p7app/features/config/config_provider.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/p7_app.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/views/widgets/restart_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'main_app/flavour/flavour_config.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  // user trust SSL certificate for jobxprss.com
  await _loadCertificate();

  setupLocator();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  var key =UniqueKey();
  FlavorConfig(
    flavor: Flavor.PRODUCTION,
    color: Colors.deepPurpleAccent,
    values: FlavorValues(baseUrl: kBaseUrlProd),
  );
  runApp(
    RestartWidget (
      child: ChangeNotifierProvider(
        create: (context) => ConfigProvider(),
        child: P7App(key),
      ),
    ),
  );
}

Future _loadCertificate()async{
  ByteData data = await rootBundle.load('assets/certification/jobxprss-com-chain.pem');
  SecurityContext context = SecurityContext.defaultContext;
  return context.setTrustedCertificatesBytes(data.buffer.asUint8List());
}

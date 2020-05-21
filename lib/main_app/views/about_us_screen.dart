import 'package:flutter/material.dart';
import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/views/pge_view_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  AboutUsScreen({Key key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  var url = "${FlavorConfig?.instance?.values?.baseUrl}/about-us/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.aboutUsText),
      ),
      body: PgeViewWidget(url: url,),
    );
  }
}

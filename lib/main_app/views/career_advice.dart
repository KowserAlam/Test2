import 'package:flutter/material.dart';
import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/views/pge_view_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CareerAdviceScreen extends StatefulWidget {
  CareerAdviceScreen({Key key}) : super(key: key);

  @override
  _CareerAdviceScreenState createState() => _CareerAdviceScreenState();
}

class _CareerAdviceScreenState extends State<CareerAdviceScreen> {
  var url = "${FlavorConfig?.instance?.values?.baseUrl}/career-advice/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.careerAdviceText),
      ),
      body: PgeViewWidget(url: url,),
    );
  }
}

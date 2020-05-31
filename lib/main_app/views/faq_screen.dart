import 'package:flutter/material.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/views/widgets/pge_view_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FAQScreen extends StatefulWidget {
  FAQScreen({Key key}) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  var url = "${FlavorConfig?.instance?.values?.baseUrl}${Urls.faqWeb}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.faqText),
      ),
      body: PgeViewWidget(url: url,),
    );
  }
}

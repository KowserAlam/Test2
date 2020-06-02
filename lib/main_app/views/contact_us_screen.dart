import 'package:flutter/material.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/views/widgets/pge_view_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({Key key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  var url = "${FlavorConfig?.instance?.values?.baseUrl}${Urls.contactUsWeb}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.contactUsText),
      ),
      body: ListView(
        children: [
          Container(

          )
        ],
      ),
    );
  }
}

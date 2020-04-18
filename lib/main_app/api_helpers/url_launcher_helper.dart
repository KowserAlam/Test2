import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';



class UrlLauncherHelper {
  static launchUrl(String url) async {
    debugPrint("Launching url: $url");
    if (url != null) {
      bool _canLaunch = await canLaunch(url);
      if (_canLaunch) {
        launchUrl(url);
      }
    }
  }
}

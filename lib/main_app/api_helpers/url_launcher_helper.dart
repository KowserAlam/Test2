import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static launchUrl(String url) async {
    debugPrint("Launching url: $url");

    bool _canLaunch = await canLaunch(url);
    if (_canLaunch) {
      launch(url);
    } else {
      BotToast.showText(text: "Unable to launch");
    }
  }
  static sendMail(String email) async {
//    debugPrint("Launching url: $email");

    bool _canLaunch = await canLaunch("mailto:$email");
    if (_canLaunch) {
      launch("mailto:$email");

    } else {
      BotToast.showText(text: "Unable to launch");
    }
  }
}

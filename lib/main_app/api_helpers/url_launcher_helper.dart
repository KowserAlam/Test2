import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';



class UrlLauncherHelper {
  static launchUrl(String url) async {
    debugPrint("Launching url: $url");
    if (url != null) {
      bool _canLaunch = await canLaunch(url);
      if (_canLaunch) {
        launchUrl(url);
      }else{
        BotToast.showText(text: "Unable to launch");
      }
    }else{
      BotToast.showText(text: "Unable to launch");
    }
  }
}

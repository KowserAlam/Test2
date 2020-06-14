import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {

  static launchFacebookUrl(String facebookUserName)async{
    var fbProtocolUrl = "fb://$facebookUserName";
    var fallbackUrl = "https://${StringUtils.facebookBaseUrl}$facebookUserName";
    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);
      if (!launched) {
        await launchUrl(fallbackUrl);;
      }
    } catch (e) {
      await launchUrl(fallbackUrl);
    }
  }


  static launchUrl(String url) async {
    debugPrint("Launching url: $url");
    if(!url.contains('https://', 0)){
      url = 'https://' + url;
    }

    bool _canLaunch = await canLaunch(url);
    if (_canLaunch) {
      launch(url,forceSafariVC: false,forceWebView: false);
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';

class SubscribeJobAlert extends StatefulWidget {

  SubscribeJobAlert({
    Key key,
  }) : super(key: key);

  @override
  _SubscribeJobAlertState createState() => _SubscribeJobAlertState();
}

class _SubscribeJobAlertState extends State<SubscribeJobAlert> {
  bool jobAlerSstatus = false;
  bool busy = false;

  initState() {
    _getStatus();
    super.initState();
  }

  _updateUI() {
    if (this.mounted) {
      setState(() {});
    }
  }

  _toggle() async {
    try {
      _updateUI();
      busy = true;
      var proID = await AuthService.getInstance()
          .then((value) => value.getUser().professionalId);
      var url = "${Urls.jobAlertOnOffUrl}";
      var res = await ApiClient()
          .putRequest(url, {"job_alert_status": !jobAlerSstatus});
//      var res = await ApiClient().getRequest(Urls.jobAlertOnOffUrl);
      print(res.body);
      var decodedJson = json.decode(res.body);
      print(decodedJson);
      jobAlerSstatus = decodedJson["job_alert_status"] ?? false;
      busy = false;
      _updateUI();
    } catch (e) {
      busy = false;
      print(e);
      _updateUI();
    }
  }

  _getStatus() async {
    try {
      busy = true;
      _updateUI();
      var res = await ApiClient().getRequest(Urls.jobAlertStatusUrl);
      var decodedJson = json.decode(res.body);
      print(decodedJson);
      if (decodedJson["status"] == "subscribed") {
        jobAlerSstatus = true;
        busy = false;
        _updateUI();
      } else {
        busy = false;
        jobAlerSstatus = false;
        _updateUI();
      }
    } catch (e) {
      busy = false;
      print(e);
      _updateUI();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:     Text(StringResources.getJobAlertByEmailText),
      trailing: busy
          ? Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(8.0),
        child: Loader(),
      )
          : Container(
        child: Switch(
          key: Key('subscribeEmailNotificationToggleButton'),
          value: jobAlerSstatus,
          onChanged: (bool value) {
            _toggle();
          },
        ),
      ),
    );
//    return Row(
//      children: [
//        Text(jobAlerSstatus
//            ? StringResources.unSubscribeForJobAlertText
//            : StringResources.subscribeForJobAlertText),
//        Container(
//          height: 40,
//          width: 40,
//          child: busy
//              ? Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Loader(),
//                )
//              : Container(
//                  child: Checkbox(
//                    value: jobAlerSstatus,
//                    onChanged: (bool value) {
//                      _toggle();
//                    },
//                  ),
//                ),
//        ),
//      ],
//    );
  }
}

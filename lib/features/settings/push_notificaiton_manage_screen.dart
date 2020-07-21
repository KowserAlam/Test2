import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/subscribe_job_alert.dart';

class PushNotificationManageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.managePushNotificationText),
      ),
      body: ListView(
        children: [
        ],
      ),
    );
  }
}

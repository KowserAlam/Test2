import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/features/settings/widgets/subscribe_job_alert.dart';

class EmailSubscriptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.emailSubscriptionText),
      ),
      body: ListView(
        children: [
          ListTile(title: SubscribeJobAlert(
          ))
        ],
      ),
    );
  }
}

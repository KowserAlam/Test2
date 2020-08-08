import 'package:flutter/material.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/features/settings/widgets/subscribe_job_alert.dart';
import 'package:provider/provider.dart';

class PushNotificationManageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.managePushNotificationText),
      ),
      body: Consumer<SettingsViewModel>(
        builder: (context, vm,_) {
          return ListView(
            children: [
              ListTile(
                title: Text(StringResources.receiveNewsNUpdatesText),
                trailing: Switch(value: vm.isEnabledNewsPush, onChanged: (bool value) {
                  vm.togglePushNotificationNewUpdate();
                },),
              )
            ],
          );
        }
      ),
    );
  }
}

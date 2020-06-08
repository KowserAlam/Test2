import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/notification/view_models/notificaion_view_model.dart';
import 'package:p7app/features/notification/views/widgets/notification_tile_widget.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    var notiVM = Provider.of<NotificationViewModel>(context, listen: false);
    notiVM.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.notificationsText),
      ),
      body: Consumer<NotificationViewModel>(
          builder: (context, notificationViewModel, _) {
        return ListView.builder(
            itemCount: notificationViewModel.notifications.length,
            itemBuilder: (BuildContext context, int index) {
              var notification = notificationViewModel.notifications[index];
              return NotificationTile(
                notification,
                onTap: () {},
              );
            });
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:p7app/features/notification/views/widgets/notification_tile_widget.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.notificationsText),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 7,
            itemBuilder: (BuildContext context, int index){
              return NotificationTile(onTap: (){},);
            }),
      ),
    );
  }
}

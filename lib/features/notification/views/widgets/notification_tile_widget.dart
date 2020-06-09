import 'package:flutter/material.dart';
import 'package:p7app/features/notification/models/notification_model.dart';
import 'package:p7app/features/notification/notification_helpers.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';

class NotificationTile extends StatefulWidget {
  final Function onTap;
  final NotificationModel notificationModel;

  NotificationTile(this.notificationModel, {this.onTap});

  @override
  _NotificationTileState createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    var primaryColor = Theme.of(context).primaryColor;
    var createdAt = widget.notificationModel.createdAt;
    var time = "${NotificationHelper.calculateTimeStamp(createdAt)} ago";

    bool isRead = widget.notificationModel?.isRead ?? false;
    var backgroundColor = isRead? scaffoldBackgroundColor : AppTheme.selectedBackgroundColor;
    var titleColor = isRead?Theme.of(context).textTheme.subtitle1.color: primaryColor;
    return Container(
      height: 65,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          color: backgroundColor, boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
        BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
      ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          height: 15,
                          child: Text(
                            widget.notificationModel.title ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: titleColor,
                                fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Container(
                        height: 15,
                        width: 60,
                        child: Center(
                            child: Text(
                          time,
                          style: TextStyle(fontSize: 10, color: primaryColor),
                        )),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 5, top: 2),
                    child: Text(
                      widget.notificationModel.message ?? "",
                      style: TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

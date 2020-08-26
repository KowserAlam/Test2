import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/notification/models/notification_model.dart';
import 'package:p7app/features/notification/notification_helpers.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';

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
    var backgroundColor = Theme.of(context).backgroundColor;
    var primaryColor = Theme.of(context).primaryColor;
    var createdAt = widget.notificationModel.createdAt;
    var time = "${NotificationHelper.calculateTimeStamp(createdAt)} ago";

    bool isRead = widget.notificationModel?.isRead ?? false;
    var tileBackgroundColor =
        isRead ? backgroundColor : AppTheme.selectedBackgroundColor;
    var titleColor = Colors.black;
    return Container(
      height: 70,
      margin: EdgeInsets.symmetric(
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: tileBackgroundColor,
        boxShadow: CommonStyle.boxShadow
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                 FontAwesomeIcons.bell,
                    size: 35,
                    color:   isRead?  Colors.grey: Colors.orange,
                  ),
                ),
                Expanded(
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
                                      fontWeight: isRead
                                          ? FontWeight.normal
                                          : FontWeight.bold,
                                      color: titleColor,
                                      fontSize: isRead ? 13 : 14),
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
                                style: TextStyle(fontSize: 10),
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
                            style: TextStyle(fontSize: 12,color: Colors.grey[800]),
                            overflow: TextOverflow.ellipsis,

                            maxLines: 2,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

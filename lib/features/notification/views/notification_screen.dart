import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p7app/features/notification/models/notification_model.dart';
import 'package:p7app/features/notification/view_models/notificaion_view_model.dart';
import 'package:p7app/features/notification/views/widgets/no_notification_widget.dart';
import 'package:p7app/features/notification/views/widgets/notification_tile_widget.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/main_app/util/logger_helper.dart';
import 'package:p7app/main_app/views/widgets/failure_widget.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with AfterLayoutMixin {
  ScrollController _scrollController = ScrollController();

  NotificationViewModel _notiController = Get.find();

  @override
  void afterFirstLayout(BuildContext context) {
    // var notiVM = Provider.of<NotificationViewModel>(context, listen: false);
    _notiController.getNotifications();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _notiController.getMoreData();
      }
    });
  }

  Widget errorWidget() {
    // var jobListViewModel =
    //     Provider.of<NotificationViewModel>(context, listen: false);
    return Obx(() {
      switch (_notiController.appError.value) {
        case AppError.serverError:
          return FailureFullScreenWidget(
            errorMessage: StringResources.unableToLoadData,
            onTap: () {
              return _notiController.refresh();
            },
          );

        case AppError.networkError:
          return FailureFullScreenWidget(
            errorMessage: StringResources.unableToReachServerMessage,
            onTap: () {
              return _notiController.refresh();
            },
          );

        default:
          return FailureFullScreenWidget(
            errorMessage: StringResources.somethingIsWrong,
            onTap: () {
              return _notiController.refresh();
            },
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.notificationsText),
        key: Key('notificationsText'),
      ),
      body: Obx(() {
        if ( _notiController.shouldShowPageLoader) {
          return Center(
            child: Loader(),
          );
        }
        else if ( _notiController.shouldShowAppError) {
          return errorWidget();
        }
        else if ( _notiController.shouldShowNoNotification) {
          return NoNotificationWidget();
        }else if(_notiController.notifications.length == 0){
          return SizedBox();
        }

        var notifications = _notiController.notifications;
        return RefreshIndicator(
          onRefresh: () async =>  _notiController.getNotifications(),
          child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
               controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 4),
              itemCount: notifications.length,
              itemBuilder: (BuildContext context, int index) {
                var notification =  notifications[index];
                return NotificationTile(
                  notification,
                  onTap: () {
                     // _notiController.markAsRead(index);
                    _showDialog(context, notification, index);
                  },
                );
              }),
        );
      }),
    );
  }
}

_showDialog(context, NotificationModel notification, int index) {
//  print(notification.createdAt);
//  print(DateTime.now());

  showCupertinoDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          // title: Text(notification.title ?? ""),
          content: Column(
            children: [
              Text(
                DateFormatUtil.formatDateTime(notification.createdAt) ?? "",
                style: TextStyle(
                    fontSize: 10,),
              ),
              SizedBox(
                height: 10,
              ),
              Text(notification.message ?? ""),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          actions: [
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(StringResources.closeText),
            ),
//      IconButton(icon: Icon(Icons.close),onPressed: (){},),
          ],
        );
      });
}

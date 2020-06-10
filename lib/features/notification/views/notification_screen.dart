import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/notification/models/notification_model.dart';
import 'package:p7app/features/notification/repositories/notification_repository.dart';
import 'package:p7app/features/notification/view_models/notificaion_view_model.dart';
import 'package:p7app/features/notification/views/widgets/no_notification_widget.dart';
import 'package:p7app/features/notification/views/widgets/notification_tile_widget.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/main_app/widgets/app_drawer.dart';
import 'package:p7app/main_app/widgets/failure_widget.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with AfterLayoutMixin {
  ScrollController _scrollController = ScrollController();

  @override
  void afterFirstLayout(BuildContext context) {
    var notiVM = Provider.of<NotificationViewModel>(context, listen: false);
    notiVM.getNotifications();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        notiVM.getMoreData();
      }
    });
  }

  errorWidget() {
    var jobListViewModel =
        Provider.of<NotificationViewModel>(context, listen: false);
    switch (jobListViewModel.appError) {
      case AppError.serverError:
        return FailureFullScreenWidget(
          errorMessage: StringUtils.unableToLoadData,
          onTap: () {
            return Provider.of<NotificationViewModel>(context, listen: false)
                .refresh();
          },
        );

      case AppError.networkError:
        return FailureFullScreenWidget(
          errorMessage: StringUtils.unableToReachServerMessage,
          onTap: () {
            return Provider.of<NotificationViewModel>(context, listen: false)
                .refresh();
          },
        );

      default:
        return FailureFullScreenWidget(
          errorMessage: StringUtils.somethingIsWrong,
          onTap: () {
            return Provider.of<NotificationViewModel>(context, listen: false)
                .refresh();
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.notificationsText),
      ),
      drawer: AppDrawer(),
      body: Consumer<NotificationViewModel>(
          builder: (context, notificationViewModel, _) {
        if (notificationViewModel.shouldShowPageLoader) {
          return Center(
            child: Loader(),
          );
        }
        if (notificationViewModel.shouldShowAppError) {
          return errorWidget();
        }
        if (notificationViewModel.shouldShowNoNotification) {
          return NoNotificationWidget();
        }

        return RefreshIndicator(
          onRefresh: () async => notificationViewModel.getNotifications(),
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 4),
              itemCount: notificationViewModel.notifications.length,
              itemBuilder: (BuildContext context, int index) {
                var notification = notificationViewModel.notifications[index];
                return NotificationTile(
                  notification,
                  onTap: () {
                    notificationViewModel.markAsRead(index);
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
          title: Text(notification.title ?? ""),
          content: Column(
            children: [
              Text(
                DateFormatUtil.formatDateTime(notification.createdAt) ?? "",
                style: TextStyle(
                    fontSize: 10, color: Theme.of(context).primaryColor),
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
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(StringUtils.closeText),
            ),
//      IconButton(icon: Icon(Icons.close),onPressed: (){},),
          ],
        );
      });
}

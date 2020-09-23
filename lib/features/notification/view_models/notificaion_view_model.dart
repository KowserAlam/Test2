import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:p7app/features/notification/models/notification_model.dart';
import 'package:p7app/main_app/util/live_update_service.dart';
import 'package:p7app/features/notification/repositories/notification_repository.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class NotificationViewModel extends GetxController {
  var appError = AppError.none.obs;
  var notifications = <NotificationModel>[].obs;
  var isFetchingData = false.obs;
  var isGettingMoreData = false.obs;
  bool _hasMoreData = false;
  int _page = 1;

  @override
  void onInit() {
    AuthService.getInstance().then((value) => value.isAccessTokenValid()).then((value) {
      if(value){ // if logged in
        getNotifications();
        // listenNotification();
      }

    });

  }

  Future<void> refresh() {
    _page = 1;
    return getNotifications();
  }

  void listenNotification() {
    logger.i("listenNotification");
    var liveService = Get.find<LiveUpdateService>();

    liveService.notificationLive.listen((value) {
      logger.i(value.toString());
      int index = notifications.indexWhere((element) => element.id == value.id);
      if (index != -1) {
        notifications.insert(index, value);
      } else {
        _showInAppNotification(value);
        notifications.insert(0, value);
      }
    }, onError: (e) {
      logger.e(e);
    });
  }

  Future<void> getNotifications() async {
    _page = 1;
    isFetchingData.value = true;

    var res = await NotificationRepository().getNotificationsList();
    res.fold((l) {
      isFetchingData.value = false;
      _hasMoreData = false;
      appError.value = l;
    }, (r) {
      appError.value = AppError.none;
      isFetchingData.value = false;
      notifications.value = r.notifications ?? [];
      _hasMoreData = r.next;
    });
  }

  getMoreData() async {
    if (_hasMoreData && !isGettingMoreData.value) {
      _page++;
      isGettingMoreData.value = true;

      var res =
          await NotificationRepository().getNotificationsList(page: _page);
      res.fold((l) {
        isGettingMoreData.value = false;
        appError.value = l;
        _hasMoreData = false;
      }, (r) {
        isGettingMoreData.value = false;
        _hasMoreData = r.next;
        notifications.addAll(r.notifications);
      });
    }
  }

  markAsRead(int index) {
    if (!notifications[index].isRead) {
      notifications[index].isRead = true;

      NotificationRepository()
          .markAsRead(notifications[index].id)
          .then((value) {
        if (!value) {
          notifications[index].isRead = false;
        }
      });
    }
  }

  _showInAppNotification(NotificationModel notification) {
    // BotToast.showNotification(
    //     title: (_) => Text(notification?.title ?? ""),
    //     subtitle: (_) => Text(notification?.message ?? ""),
    //     onTap: () {
    //       Navigator.push(context,
    //           CupertinoPageRoute(builder: (context) => NotificationScreen()));
    //     },onClose: (){
    //       BotToast.cleanAll();
    // });

    BotToast.showSimpleNotification(
        title: notification?.title ?? "",
        subTitle: notification?.message ?? "",
        onTap: () {
          // Navigator.push(context,
          //     CupertinoPageRoute(builder: (context) => NotificationScreen()));
        },
        onClose: () {
          BotToast.cleanAll();
        });
  }
  

  bool get hasUnreadNotification {
    var hasUnread = false;
    for(var v in notifications) {
      if(!v.isRead){
        hasUnread = true;
        break;
      }
    }
    return hasUnread;
  }

  bool get shouldShowPageLoader =>
      isFetchingData.value && notifications.length == 0;

  bool get shouldShowAppError => appError.value != AppError.none && notifications.length == 0;

  bool get shouldShowNoNotification =>
      !isFetchingData.value && appError.value == AppError.none && notifications.length == 0;
}

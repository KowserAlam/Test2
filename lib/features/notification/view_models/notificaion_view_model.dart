import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:p7app/features/notification/models/notification_model.dart';
import 'package:p7app/features/notification/repositories/live_update_service.dart';
import 'package:p7app/features/notification/repositories/notification_repository.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/util/logger_helper.dart';


class NotificationViewModel with ChangeNotifier {

  AppError _appError;
  List<NotificationModel> _notifications = [];
  bool _isFetchingData = false;
  bool _isGettingMoreData = false;
  bool _hasMoreData = false;
  int _page = 1;

  Future<void> refresh() {
    _page = 1;
    return getNotifications();
  }


  void listenNotification(){
    logger.i("listening");
    locator<LiveUpdateService>().notificationUpdate.listen((value) {
      logger.i(value);
      refresh();
    },onError: (e){
      logger.e(e);
    });
  }

  Future<void> getNotifications() async {
    _page = 1;
    _isFetchingData = true;
    notifyListeners();
    var res = await NotificationRepository().getNotificationsList();
    res.fold((l) {
      _isFetchingData = false;
      _hasMoreData = false;
      _appError = l;
      notifyListeners();
    }, (r) {
      _isFetchingData = false;
      _notifications = r.notifications ?? [];
      _hasMoreData = r.next;
      notifyListeners();
    });
  }

  getMoreData() async {

    if (_hasMoreData && !isGettingMoreData) {
      _page++;
      _isGettingMoreData = true;
      notifyListeners();
      var res = await NotificationRepository().getNotificationsList(page: _page);
      res.fold((l) {
        _isGettingMoreData = false;
        _appError = l;
        _hasMoreData = false;
        notifyListeners();
      }, (r) {
        _isGettingMoreData = false;
        _hasMoreData = r.next;
        _notifications.addAll(r.notifications);
        notifyListeners();
      });
    }
  }

  markAsRead(int index) {
    if (!_notifications[index].isRead) {
      notifications[index].isRead = true;
      notifyListeners();
      NotificationRepository()
          .markAsRead(notifications[index].id)
          .then((value) {
        if (!value) {
          notifications[index].isRead = false;
          notifyListeners();
        }
      });
    }
  }

  List<NotificationModel> get notifications => _notifications;

  set notifications(List<NotificationModel> value) {
    _notifications = value;
  }

  AppError get appError => _appError;

  set appError(AppError value) {
    _appError = value;
  }

  bool get isGettingMoreData => _isGettingMoreData;

  bool get isFetchingData => _isFetchingData;

  bool get hasMoreData => _hasMoreData;

  bool get shouldShowPageLoader => _isFetchingData && notifications.length == 0;

  bool get shouldShowAppError => _appError != null && notifications.length == 0;

  bool get shouldShowNoNotification =>
      !_isFetchingData && _appError == null && notifications.length == 0;
}

import 'package:flutter/cupertino.dart';
import 'package:p7app/features/notification/models/notification_model.dart';
import 'package:p7app/features/notification/repositories/notification_repository.dart';
import 'package:p7app/main_app/failure/app_error.dart';

class NotificationViewModel with ChangeNotifier {
  AppError _appError;
  List<NotificationModel> _notifications =[];

  Future<void> getNotifications() async {
    var res = await NotificationRepository().getNotificationsList();
    res.fold((l) {
      _appError = l;
      notifyListeners();
    }, (r) {
      _notifications = r.notifications;
      notifyListeners();
    });
  }

  List<NotificationModel> get notifications => _notifications;

  set notifications(List<NotificationModel> value) {
    _notifications = value;
  }

  AppError get appError => _appError;

  set appError(AppError value) {
    _appError = value;
  }
}

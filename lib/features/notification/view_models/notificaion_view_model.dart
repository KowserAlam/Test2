import 'package:flutter/cupertino.dart';
import 'package:p7app/features/notification/models/notification_model.dart';
import 'package:p7app/features/notification/repositories/notification_repository.dart';
import 'package:p7app/main_app/failure/app_error.dart';

class NotificationViewModel with ChangeNotifier {
  AppError _appError;
  List<NotificationModel> _notifications =[];
  bool _isFetchingData = false;
  bool _isGettingMoreData = false;
  bool _hasMoreData = false;


  Future<void>  refresh(){
    return getNotifications();
  }

  Future<void> getNotifications() async {
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
      _notifications = r.notifications??[];
      _hasMoreData = r.next;
      notifyListeners();
    });
  }

  getMoreData()async{
    if(!_hasMoreData && _isGettingMoreData){
      return;
    }
    _isGettingMoreData = true;
    notifyListeners();
    var res = await NotificationRepository().getNotificationsList();
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
  bool get shouldShowNoNotification => !_isFetchingData&&_appError == null && notifications.length == 0;
}

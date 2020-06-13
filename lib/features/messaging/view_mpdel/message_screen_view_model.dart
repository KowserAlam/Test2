
import 'package:flutter/cupertino.dart';
import 'package:p7app/features/messaging/model/message_model.dart';
import 'package:p7app/features/messaging/repositories/message_repository.dart';
import 'package:p7app/main_app/failure/app_error.dart';

class MessageScreenViewModel with ChangeNotifier {
  AppError _appError;
  List<MessageModel> _notifications = [];
  bool _isFetchingData = false;
  bool _isGettingMoreData = false;
  bool _hasMoreData = false;

  Future<void> refresh() {
    return getNotifications();
  }

  Future<void> getNotifications() async {
    _isFetchingData = true;
    notifyListeners();
    var res = await MessageRepository().getMessageList();
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
      _isGettingMoreData = true;
      notifyListeners();
      var res = await MessageRepository().getMessageList();
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
      MessageRepository()
          .markAsRead(notifications[index].id)
          .then((value) {
        if (!value) {
          notifications[index].isRead = false;
          notifyListeners();
        }
      });
    }
  }

  List<MessageModel> get notifications => _notifications;

  set notifications(List<MessageModel> value) {
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
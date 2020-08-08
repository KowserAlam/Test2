import 'package:flutter/cupertino.dart';
import 'package:p7app/features/messaging/model/conversation_screen_data_model.dart';
import 'package:p7app/features/messaging/model/message_sender_data_model.dart';
import 'package:p7app/features/messaging/repositories/message_repository.dart';
import 'package:p7app/main_app/failure/app_error.dart';

class ConversationViewModel with ChangeNotifier {
  List<Message> _messages = [];
  AppError _appError;
  bool _isFetchingData = false;
  bool _isGettingMoreData = false;
  bool _hasMoreData = false;

  Future<void> getConversation(String senderId) async {
    _isFetchingData = true;
    notifyListeners();
    var res = await MessageRepository().getConversation(senderId);
    res.fold((l) {
      _isFetchingData = false;
      _hasMoreData = false;
      _appError = l;
      notifyListeners();
    }, (r) {
      _isFetchingData = false;
      _messages = r.messages ?? [];
      _hasMoreData = r.pages.nextUrl;
      notifyListeners();
    });
  }

  getMoreData(String senderId) async {
    if (_hasMoreData && !isGettingMoreData) {
      _isGettingMoreData = true;
      notifyListeners();
      var res = await MessageRepository().getConversation(senderId);
      res.fold((l) {
        _isGettingMoreData = false;
        _appError = l;
        _hasMoreData = false;
        notifyListeners();
      }, (r) {
        _isGettingMoreData = false;
        _hasMoreData = r.pages.nextUrl ?? false;
        _messages.addAll(r.messages);
        notifyListeners();
      });
    }
  }

  List<Message> get messages => _messages;

  bool get hasMoreData => _hasMoreData;

  bool get isGettingMoreData => _isGettingMoreData;

  bool get isFetchingData => _isFetchingData;

  AppError get appError => _appError;
}

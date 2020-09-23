import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  int id;
  String createdBy;
  DateTime createdAt;
  String createdFrom;
  String title;
  String message;
  String recipient;
  bool isRead;

  NotificationModel(
      {this.id,
      this.createdBy,
      this.createdAt,
      this.createdFrom,
      this.title,
      this.message,
      this.recipient,
      this.isRead});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['created_by'];
    if (json['created_at'] != null) {
      createdAt = DateTime.parse(json['created_at']);
    }
    createdFrom = json['created_from'];
    title = json['title'];
    message = json['message'];
    recipient = json['recipient'];
    isRead = json['is_read'];
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        createdBy,
        createdAt,
        createdFrom,
        title,
        message,
        recipient,
        isRead
      ];

  @override
  String toString() {
    return 'NotificationModel{id: $id, createdBy: $createdBy, createdAt: $createdAt, createdFrom: $createdFrom, title: $title, message: $message, recipient: $recipient, isRead: $isRead}';
  }
}

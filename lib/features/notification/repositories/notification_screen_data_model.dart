import 'package:p7app/features/notification/models/notification_model.dart';

class NotificationScreenDataModel {
  int count;
  bool next;
  bool previous;
  List<NotificationModel> notifications;

  NotificationScreenDataModel(
      {this.count, this.next, this.previous, this.notifications});

  NotificationScreenDataModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json["pages"]['next_url'] != null;
    previous = json['previous'];
    if (json['results'] != null) {
      notifications = new List<NotificationModel>();
      json['results'].forEach((v) {
        notifications.add(new NotificationModel.fromJson(v));
      });
    }
  }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['count'] = this.count;
//    data['next'] = this.next;
//    data['previous'] = this.previous;
//    if (this.results != null) {
//      data['results'] = this.results.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
}
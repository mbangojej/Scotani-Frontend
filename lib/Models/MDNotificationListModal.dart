import 'package:skincanvas/Models/MDPagination.dart';

class MDNotificationListModal {
  int? status;
  String? message;
  MDNotificationData? data;

  MDNotificationListModal({this.status, this.message, this.data});

  MDNotificationListModal.fromJson(Map<String, dynamic> json) {
    status = json['status']??0;
    message = json['message']??'';
    data = json['data'] != null ? new MDNotificationData.fromJson(json['data']) : null;
  }
}

class MDNotificationData {
  List<Notifications>? notifications;
  Pagination? pagination;

  MDNotificationData({this.notifications,this.pagination});

  MDNotificationData.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : Pagination(page: 0,limit: 0,pages: 0,total: 0);
  }
}

class Notifications {
  String? sId;
  String? description;
  bool? status;
  String? title;

  Notifications({this.sId, this.description, this.status, this.title});

  Notifications.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??"";
    description = json['description']??"";
    status = json['status']??false;
    title = json['title']??'';
  }

}

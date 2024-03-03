class MDChangeNotificationStatusModal {
  int? status;
  String? message;
  MDChangeNotificationStatusData? data;

  MDChangeNotificationStatusModal({this.status, this.message, this.data});

  MDChangeNotificationStatusModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new MDChangeNotificationStatusData.fromJson(json['data']) : null;
  }
}

class MDChangeNotificationStatusData {
  int? status;

  MDChangeNotificationStatusData({this.status});

  MDChangeNotificationStatusData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }
}

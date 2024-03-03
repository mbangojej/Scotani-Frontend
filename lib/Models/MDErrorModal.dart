class MDErrorModal {
  int? status;
  String? message;
  ErrorModalData? data;

  MDErrorModal({this.status, this.message, this.data});

  MDErrorModal.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    message = json['message'] ?? '';
    data =
        json['data'] != null ? new ErrorModalData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class ErrorModalData {
  String? userId;

  ErrorModalData({this.userId});

  ErrorModalData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? '';
  }
}

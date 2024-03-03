class MDUserModal {
  int? status;
  String? message;
  MDUserData? data;

  MDUserModal({this.status, this.message, this.data});

  MDUserModal.fromJson(Map<String, dynamic> json) {
    status = json['status']??0;
    message = json['message']??'';
    data = json['data'] != null ? new MDUserData.fromJson(json['data']) : null;
  }

}

class MDUserData {
  String? userId;
  String? accessToken;
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? userImage;
  int? emailVerified;
  int? sendNotification;

  MDUserData(
      {this.userId,
        this.accessToken,
        this.fullName,
        this.email,
        this.phone,
        this.address,
        this.userImage,
        this.emailVerified,
        this.sendNotification,
      });

  MDUserData.fromJson(Map<String, dynamic> json) {
    userId = json['userId']??"";
    accessToken = json['accessToken']??'';
    fullName = json['fullName']??'';
    email = json['email']??'';
    phone = json['phone']??'';
    address = json['address']??'';
    userImage = json['userImage']??'';
    emailVerified = json['emailVerified']??0;
    sendNotification = json['sendNotification']??0;
  }

}

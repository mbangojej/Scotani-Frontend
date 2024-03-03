class MDSettingModal {
  int? status;
  String? message;
  MDSettingData? data;

  MDSettingModal({this.status, this.message, this.data});

  MDSettingModal.fromJson(Map<String, dynamic> json) {
    status = json['status']??0;
    message = json['message']??'';
    data = json['data'] != null ? new MDSettingData.fromJson(json['data']) : null;
  }
}

class MDSettingData {
  Settings? settings;

  MDSettingData({this.settings});

  MDSettingData.fromJson(Map<String, dynamic> json) {
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }
}

class Settings {
  String? email;
  String? phone;
  String? address;
  String? instagram;
  String? facebook;
  String? twitter;
  String? linkedin;
  String? sId;

  Settings(
      {this.email,
        this.phone,
        this.address,
        this.instagram,
        this.facebook,
        this.twitter,
        this.linkedin,
        this.sId});

  Settings.fromJson(Map<String, dynamic> json) {
    email = json['email']??'';
    phone = json['phone']??'';
    address = json['address']??'';
    instagram = json['instagram']??'';
    facebook = json['facebook']??'';
    twitter = json['twitter']??'';
    linkedin = json['linkedin']??'';
    sId = json['_id']??'';
  }
}

class MDFAQModal {
  int? status;
  String? message;
  MDFAQData? data;

  MDFAQModal({this.status, this.message, this.data});

  MDFAQModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new MDFAQData.fromJson(json['data']) : null;
  }
}

class MDFAQData {
  List<MDFAQCategories>? categories;

  MDFAQData({this.categories});

  MDFAQData.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <MDFAQCategories>[];
      json['categories'].forEach((v) {
        categories!.add(new MDFAQCategories.fromJson(v));
      });
    }
  }

}

class MDFAQCategories {
  String? sId;
  String? name;
  List<Faqs>? faqs;

  MDFAQCategories({this.sId, this.name, this.faqs});

  MDFAQCategories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['faqs'] != null) {
      faqs = <Faqs>[];
      json['faqs'].forEach((v) {
        faqs!.add(new Faqs.fromJson(v));
      });
    }
  }
}

class Faqs {
  String? sId;
  String? title;
  int? displayOrder;
  String? desc;

  Faqs({this.sId, this.title, this.displayOrder, this.desc});

  Faqs.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??'';
    title = json['title']??'';
    displayOrder = json['display_order']??0;
    desc = json['desc']??'';
  }
}

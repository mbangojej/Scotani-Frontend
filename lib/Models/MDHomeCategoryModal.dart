class MDCategoriesModal {
  int? status;
  String? message;
  MDCategoriesData? data;

  MDCategoriesModal({this.status, this.message, this.data});

  MDCategoriesModal.fromJson(Map<String, dynamic> json) {
    status = json['status']??0;
    message = json['message']??"";
    data = json['data'] != null ? new MDCategoriesData.fromJson(json['data']) : null;
  }
}

class MDCategoriesData {
  List<Categories>? categories;

  MDCategoriesData({this.categories});

  MDCategoriesData.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add( Categories.fromJson(v));
      });
    }
  }
}

class Categories {
  String? sId;
  String? name;
  List<SubCategories>? subCategories;
  String? image;

  Categories({this.sId, this.name, this.subCategories, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??'';
    name = json['name']??'';
    if (json['subCategories'] != null) {
      subCategories = <SubCategories>[];
      json['subCategories'].forEach((v) {
        subCategories!.add( SubCategories.fromJson(v));
      });
    }
    image = json['image']??'';
  }
}

class SubCategories {
  String? sId;
  String? name;
  String? image;

  SubCategories({this.sId, this.name, this.image});

  SubCategories.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??'';
    name = json['name']??'';
    image = json['image']??"";
  }

}

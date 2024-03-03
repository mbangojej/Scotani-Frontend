// import 'package:skincanvas/Models/MDHomeCategoryModal.dart';
//
// class MDConfigurableProductModal {
//   int? status;
//   String? message;
//   MDConfigurableProductData? data;
//
//   MDConfigurableProductModal({this.status, this.message, this.data});
//
//   MDConfigurableProductModal.fromJson(Map<String, dynamic> json) {
//     status = json['status']??0;
//     message = json['message']??'';
//     data = json['data'] != null ? new MDConfigurableProductData.fromJson(json['data']) : null;
//   }
//
// }
//
// class MDConfigurableProductData {
//   List<MDConfigurableProductCategories>? categories;
//
//   MDConfigurableProductData({this.categories});
//
//   MDConfigurableProductData.fromJson(Map<String, dynamic> json) {
//     if (json['categories'] != null) {
//       categories = <MDConfigurableProductCategories>[];
//       json['categories'].forEach((v) {
//         categories!.add(new MDConfigurableProductCategories.fromJson(v));
//       });
//     }
//   }
// }
//
// class MDConfigurableProductCategories {
//   String? sId;
//   String? name;
//   String? image;
//   List<MDConfigurableProductChildCategory>? childCategory;
//
//   MDConfigurableProductCategories({this.sId, this.name, this.image, this.childCategory});
//
//   MDConfigurableProductCategories.fromJson(Map<String, dynamic> json) {
//     sId = json['_id']??'';
//     name = json['name']??'';
//     image = json['image']??'';
//     if (json['child_category'] != null) {
//       childCategory = <MDConfigurableProductChildCategory>[];
//       json['child_category'].forEach((v) {
//         childCategory!.add(new MDConfigurableProductChildCategory.fromJson(v));
//       });
//     }
//   }
// }
//
// class MDConfigurableProductChildCategory {
//   String? sId;
//   String? name;
//   String? image;
//   List<MDHomeProductProducts>? products;
//
//   MDConfigurableProductChildCategory({this.sId, this.name, this.image, this.products});
//
//   MDConfigurableProductChildCategory.fromJson(Map<String, dynamic> json) {
//     sId = json['_id']??"";
//     name = json['name']??'';
//     image = json['image']??'';
//     if (json['products'] != null) {
//       products = <MDHomeProductProducts>[];
//       json['products'].forEach((v) {
//         products!.add(new MDHomeProductProducts.fromJson(v));
//       });
//     }
//   }
// }

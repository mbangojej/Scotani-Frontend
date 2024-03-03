import 'package:skincanvas/Models/MDProductModal.dart';

class MDProductDetailModal {
  int? status;
  String? message;
  MDProductDetailData? data;

  MDProductDetailModal({this.status, this.message, this.data});

  MDProductDetailModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new MDProductDetailData.fromJson(json['data'])
        : null;
  }
}

class MDProductDetailData {
  String? productID;
  String? productName;
  String? productDescription;
  double? productPrice;
  int? minQty;
  String? productImage;
  bool? isFeatured;
  bool? isProductIntoCart;
  List<Variation>? variations;

  MDProductDetailData({
    this.productID,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.minQty,
    this.productImage,
    this.isFeatured,
    this.isProductIntoCart,
    this.variations,
  });

  MDProductDetailData.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    productPrice = json['productPrice'] != null
        ? json['productPrice'] is String
            ? double.parse(json['productPrice']) + 0.00
            : json['productPrice'] + 0.00
        : 0.00;
    minQty = json["minQty"] ?? 0;
    productImage = json['productImage'];
    isFeatured = json['isFeatured'] ?? false;
    isProductIntoCart = json['isProductIntoCart'] ?? false;
    if (json['attributes'] != null) {
      variations = <Variation>[];
      json['attributes'].forEach((v) {
        variations!.add(Variation.fromJson(v));
      });
    }
  }
}

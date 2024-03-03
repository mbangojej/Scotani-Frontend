import 'package:skincanvas/Models/MDProductModal.dart';

class MDWishListModal {
  int? status;
  String? message;
  List<Wishlist>? wishlist;

  MDWishListModal({this.status, this.message, this.wishlist});

  MDWishListModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(new Wishlist.fromJson(v));
      });
    }
  }

}

class Wishlist {
  String? sId;
  String? productId;
  String? customer;
  String? createdAt;
  String? updatedAt;
  int? iV;
  Products? product;

  Wishlist(
      {this.sId,
        this.productId,
        this.customer,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.product});

  Wishlist.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['productId'];
    customer = json['customer'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    product =
    json['product'] != null ? new Products.fromJson(json['product']) : null;
  }
}

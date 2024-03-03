import 'package:skincanvas/Models/MDPagination.dart';

class MDOrderModal {
  int? status;
  String? message;
  MDOrderData? data;

  MDOrderModal({this.status, this.message, this.data});

  MDOrderModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new MDOrderData.fromJson(json['data']) : null;
  }
}

class MDOrderData {
  List<Orders>? orders;
  Pagination? pagination;

  MDOrderData({this.orders, this.pagination});

  MDOrderData.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : Pagination(page: 0,limit: 0,pages: 0,total: 0);
  }
}




class Orders {
  String? sId;
  String? orderID;
  String? orderDate;
  int? orderStatus;
  String? deliveredDate;
  String? aboutOrder;
  double? refundedAmount;
  String? refundedDate;
  double? orderPrice;
  String? processingDate;
  String? onTheWayDate;
  String? cancelledDate;
  String? refundedMsg;
  List<OrderProducts>? products;

  Orders(
      {this.sId,
        this.orderID,
        this.orderDate,
        this.orderStatus,
        this.deliveredDate,
        this.aboutOrder,
        this.refundedAmount,
        this.refundedDate,
        this.orderPrice,
        this.processingDate,
        this.onTheWayDate,
        this.cancelledDate,
        this.refundedMsg,
        this.products});

  Orders.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??'';
    orderID = json['orderID']??"";
    orderDate = json['orderDate']??'';
    orderStatus = json['orderStatus']??0;
    deliveredDate = json['deliveredDate']??'';
    aboutOrder = json['aboutOrder']??'';
    refundedAmount = json['refundedAmount']!=null ?  json['refundedAmount']+ 0.00 : 0.00;
    refundedDate = json['refundedDate'] ?? "";
    orderPrice = json['orderPrice'] !=null ?  json['orderPrice']+ 0.00 : 0.00;
    processingDate = json['processingDate'] ?? "";
    onTheWayDate = json['onTheWayDate'] ?? "";
    cancelledDate = json['cancelledDate'] ?? "";
    refundedMsg = json['refundedMsg'] ?? "";
    if (json['products'] != null) {
      products = <OrderProducts>[];
      json['products'].forEach((v) {
        products!.add(new OrderProducts.fromJson(v));
      });
    }
  }
}



class OrderProducts {
  String? productID;
  String? productImage;
  String? productName;
  int? quantity;
  double? productPrice;
  int? color;
  int? bodyPart;


  OrderProducts({this.productID, this.productImage, this.productName,this.quantity,this.productPrice,this.color,this.bodyPart});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    productImage = json['productImage'];
    productName = json['productName'];
    quantity = json['quantity'];
    productPrice = json['productPrice'];
  }
}
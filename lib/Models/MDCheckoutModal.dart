import 'package:skincanvas/Models/MDCartModal.dart';

class MDCheckoutModal {
  int? status;
  String? message;
  Order? order;

  MDCheckoutModal({this.status, this.message, this.order});

  MDCheckoutModal.fromJson(Map<String, dynamic> json) {
    status = json['status']??0;
    message = json['message']??'';
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }
}

class Order {
  int? orderNumber;
  int? status;
  int? isDeleted;
  String? processingDate;
  String? onTheWayDate;
  String? deliveredDate;
  String? cancelledDate;
  bool? isInvoiced;
  String? invoicedAt;
  double? paidAmount;
  String? transactionId;
  String? transactionPlatform;
  String? sId;
  int? discountTotal;
  int? vatPercentage;
  List<SystemProducts>? systemProducts;
  List<NonSystemProducts>? nonSystemProducts;
  String? promotionId;
  double? subTotal;
  double? taxTotal;
  double? grandTotal;
  String? customer;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Order(
      {this.orderNumber,
        this.status,
        this.isDeleted,
        this.processingDate,
        this.onTheWayDate,
        this.deliveredDate,
        this.cancelledDate,
        this.isInvoiced,
        this.invoicedAt,
        this.paidAmount,
        this.transactionId,
        this.transactionPlatform,
        this.sId,
        this.discountTotal,
        this.vatPercentage,
        this.systemProducts,
        this.nonSystemProducts,
        this.promotionId,
        this.subTotal,
        this.taxTotal,
        this.grandTotal,
        this.customer,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Order.fromJson(Map<String, dynamic> json) {
    orderNumber = json['orderNumber']??0;
    status = json['status']??0;
    isDeleted = json['isDeleted']??0;
    processingDate = json['processingDate']??"";
    onTheWayDate = json['onTheWayDate']??"";
    deliveredDate = json['deliveredDate']??'';
    cancelledDate = json['cancelledDate']??'';
    isInvoiced = json['isInvoiced']??false;
    invoicedAt = json['invoicedAt']??'';
    paidAmount = json['paidAmount'] != null? json['paidAmount']+0.00 :0.00;
    transactionId = json['transactionId']??"";
    transactionPlatform = json['transactionPlatform']??'';
    sId = json['_id']??'';
    discountTotal = json['discountTotal']??0;
    vatPercentage = json['vatPercentage']??0;
    if (json['systemProducts'] != null) {
      systemProducts = <SystemProducts>[];
      json['systemProducts'].forEach((v) {
        systemProducts!.add(new SystemProducts.fromJson(v));
      });
    }
    if (json['nonSystemProducts'] != null) {
      nonSystemProducts = <NonSystemProducts>[];
      json['nonSystemProducts'].forEach((v) {
        nonSystemProducts!.add(new NonSystemProducts.fromJson(v));
      });
    }
    promotionId = json['promotionId']??'';
    subTotal = json['subTotal'] != null? json['subTotal']+0.00 :0.00;
    taxTotal = json['taxTotal'] != null? json['taxTotal']+0.00 :0.00;
    grandTotal = json['grandTotal'] != null? json['grandTotal']+0.00 :0.00;
    customer = json['customer'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}


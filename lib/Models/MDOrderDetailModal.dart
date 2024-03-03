class MDOrderDetailModal {
  int? status;
  String? message;
  List<Order>? order;

  MDOrderDetailModal({this.status, this.message, this.order});

  MDOrderDetailModal.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    message = json['message'] ?? '';
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(new Order.fromJson(v));
      });
    }
  }
}

class Order {
  String? sId;
  String? orderID;
  String? orderDate;
  String? orderStatus;
  String? deliveredDate;
  double? orderPrice;
  double? refundedAmount;
  String? refundedMsg;
  String? refundedDate;
  double? grandTotal;
  List<Products>? products;
  String? aboutOrder;

  Order(
      {this.sId,
        this.orderID,
        this.orderDate,
        this.orderStatus,
        this.deliveredDate,
        this.orderPrice,
        this.refundedAmount,
        this.refundedMsg,
        this.refundedDate,
        this.grandTotal,
        this.products,
        this.aboutOrder});

  Order.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    orderID = json['orderID'] ?? "";
    orderDate = json['orderDate'] ?? '';
    orderStatus = json['orderStatus'] ?? '';
    deliveredDate = json['deliveredDate'] ?? '';
    orderPrice = json['orderPrice'] != null ? json['orderPrice'] + 0.00 : 0.00;
    refundedAmount = json['refundedAmount'] != null ? json['refundedAmount'] + 0.00 : 0.00;
    refundedMsg = json['refundedMsg'] ?? '';
    refundedDate = json['refundedDate'] ?? '';
    grandTotal = json['grandTotal'] != null ? json['grandTotal'] + 0.00 : 0.00;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    } else {
      products = <Products>[];
    }
    aboutOrder = json['aboutOrder'] ?? '';
  }
}

class Products {
  String? productImage;
  bool? isRefunded;
  String? sId;
  String? productId;
  String? variationId;
  List<Designs>? designs;
  int? quantity;
  double? price;
  String? designImprintId;
  double? designImprintPrice;
  int? color;
  int? bodyPart;
  double? subTotal;
  String? productID;
  String? productName;

  Products(
      {this.productImage,
        this.isRefunded,
        this.sId,
        this.productId,
        this.variationId,
        this.designs,
        this.quantity,
        this.price,
        this.designImprintId,
        this.designImprintPrice,
        this.color,
        this.bodyPart,
        this.subTotal,
        this.productID,
        this.productName});

  Products.fromJson(Map<String, dynamic> json) {
    productID = json['productID'] ?? '';
    productImage = json['productImage'] ?? '';
    productName = json['productName'] ?? '';
    isRefunded = json['isRefunded'] ?? false;
    sId = json['_id'] ?? '';
    productId = json['productId'] ?? '';
    variationId = json['variationId'] ?? '';
    if (json['designs'] != null) {
      designs = <Designs>[];
      json['designs'].forEach((v) {
        designs!.add(new Designs.fromJson(v));
      });
    } else {
      designs = <Designs>[];
    }
    quantity = json['quantity'] ?? 0;
    price = json['price'] != null
        ? json['price'] is String
            ? double.parse(json['price'])
            : json['price'] + 0.00
        : 0.00;
    designImprintId = json['designImprintId'] ?? '';
    designImprintPrice = json['designImprintPrice'] != null
        ? json['designImprintPrice'] is String
            ? double.parse(json['designImprintPrice'])
            : json['designImprintPrice'] + 0.00
        : 0.00;
    color = json['color'] ?? 0;
    bodyPart = json['bodyPart'] ?? 0;
    subTotal = json['subTotal'] != null
        ? json['subTotal'] is String
            ? double.parse(json['subTotal'])
            : json['subTotal'] + 0.00
        : 0.00;
    ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.productID;
    data['productImage'] = this.productImage;
    data['isRefunded'] = this.isRefunded;
    data['_id'] = this.sId;
    data['productId'] = this.productId;
    data['variationId'] = this.variationId;
    if (this.designs != null) {
      data['designs'] = this.designs!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['designImprintPrice'] = this.designImprintPrice;
    data['color'] = this.color;
    data['bodyPart'] = this.bodyPart;
    data['subTotal'] = this.subTotal;
    return data;
  }
}

class Designs {
  String? sId;
  String? prompt;
  String? image;
  String? size;
  int? quantity;
  int? price;
  String? desireText;
  dynamic? desireTextSizeGroup;
  dynamic? desireTextColorCode;

  Designs(
      {this.sId,
      this.prompt,
      this.image,
      this.size,
      this.quantity,
      this.price,
      this.desireText,
      this.desireTextSizeGroup,
      this.desireTextColorCode});

  Designs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    prompt = json['prompt'] ?? '';
    image = json['image'] ?? '';
    size = json['size'] ?? '';
    quantity = json['quantity'] ?? 0;
    price = json['price'] ?? 0;
    desireText = json['desireText'] ?? '';
    desireTextSizeGroup = json['desireTextSizeGroup'] ?? '';
    desireTextColorCode = json['desireTextColorCode'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['prompt'] = this.prompt;
    data['image'] = this.image;
    data['size'] = this.size;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['desireText'] = this.desireText;
    data['desireTextSizeGroup'] = this.desireTextSizeGroup;
    data['desireTextColorCode'] = this.desireTextColorCode;
    return data;
  }
}

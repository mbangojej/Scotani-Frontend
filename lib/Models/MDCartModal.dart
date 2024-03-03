import 'package:skincanvas/Models/MDVariationModal.dart';

class MDCartModal {
  int? status;
  String? message;
  List<Cart>? cart;

  MDCartModal({this.status, this.message, this.cart});

  MDCartModal.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    message = json['message'] ?? '';
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
  }
}

class Cart {
  String? sId;
  bool? isCheckout;
  double? discountTotal;
  int? vatPercentage;
  List<SystemProducts>? systemProducts;
  List<NonSystemProducts>? nonSystemProducts;
  String? promotionId;
  double? subTotal;
  double? taxTotal;
  double? grandTotal;
  String? customer;

  Cart(
      {this.sId,
      this.isCheckout,
      this.discountTotal,
      this.vatPercentage,
      this.systemProducts,
      this.nonSystemProducts,
      this.promotionId,
      this.subTotal,
      this.taxTotal,
      this.grandTotal,
      this.customer});

  Cart.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? "";
    isCheckout = json['isCheckout'] ?? false;
    discountTotal =
        json['discountTotal'] != null ? json['discountTotal'] + 0.00 : 0.00;

    vatPercentage = json['vatPercentage'] ?? 0;
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
    promotionId = json['promotionId'] ?? '';
    subTotal = json['subTotal'] != null
        ? json['subTotal'] is String
            ? double.parse(json['subTotal'])
            : json['subTotal'] + 0.00
        : 0.00;
    taxTotal = json['taxTotal'] != null
        ? json['taxTotal'] is String
            ? double.parse(json['taxTotal'])
            : json['taxTotal'] + 0.00
        : 0.00;
    grandTotal = json['grandTotal'] != null
        ? json['grandTotal'] is String
            ? double.parse(json['grandTotal'])
            : json['grandTotal'] + 0.00
        : 0.00;
    customer = json['customer'] ?? '';
  }
}

class SystemProducts {
  String? sId;
  String? designID;
  String? productId;
  int? quantity;
  double? price;
  double? subTotal;
  String? productName;
  String? productImage;
  int? productType;
  String? productDescription;

  SystemProducts({
    this.sId,
    this.designID,
    this.productId,
    this.quantity,
    this.price,
    this.subTotal,
    this.productName,
    this.productImage,
    this.productType,
    this.productDescription,
  });

  SystemProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    designID = json['designID'] ?? '';
    productId = json['productId'] ?? '';
    quantity = json['quantity'] ?? 0;
    price = json['price'] != null
        ? json['price'] is String
            ? double.parse(json['price'])
            : json['price'] + 0.00
        : 0.00;
    subTotal = json['subTotal'] != null
        ? json['subTotal'] is String
            ? double.parse(json['subTotal'])
            : json['subTotal'] + 0.00
        : 0.00;
    productName = json['productName'] ?? '';
    productImage = json['productImage'] ?? '';
    productType = json['productType'] ?? 0;
    productDescription = json['productDescription'] ?? "";
  }
}

class NonSystemProducts {
  String? sId;
  String? productId;
  String? variationId;
  List<Designs>? designs;
  int? quantity;
  double? price;
  int? color;
  int? bodyPart;
  double? subTotal;
  String? productName;
  String? productImage;
  int? productQuantity;
  int? productType;
  String? productDescription;

  NonSystemProducts({
    this.sId,
    this.productId,
    this.variationId,
    this.designs,
    this.quantity,
    this.price,
    this.color,
    this.bodyPart,
    this.subTotal,
    this.productName,
    this.productImage,
    this.productQuantity,
    this.productType,
    this.productDescription,
  });

  NonSystemProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    productId = json['productId'] ?? '';
    variationId = json['variationId'] ?? '';
    if (json['designs'] != null) {
      designs = <Designs>[];
      json['designs'].forEach((v) {
        designs!.add(new Designs.fromJson(v));
      });
    }
    color = json['color'] ?? 0;
    bodyPart = json['bodyPart'] ?? 0;
    quantity = json['quantity'] ?? 0;
    subTotal = json['subTotal'] != null
        ? json['subTotal'] is String
            ? double.parse(json['subTotal'])
            : json['subTotal'] + 0.00
        : 0.00;
    productName = json['productName'] ?? '';
    productImage = json['productImage'] ?? '';
    productQuantity = json['quantity'] ?? 0;
    productType = json['productType'] ?? 0;
    productDescription = json['productDescription'] ?? "";
  }
}

class Designs {
  String? sId;
  String? prompt;
  String? image;
  String? size;
  int? quantity;
  double? price;
  String? desireText;
  String? desireTextSizeGroup;
  String? desireTextColorCode;
  String? sizeDetail;

  Designs({
    this.sId,
    this.prompt,
    this.image,
    this.size,
    this.quantity,
    this.price,
    this.desireText,
    this.desireTextSizeGroup,
    this.desireTextColorCode,
    this.sizeDetail,
  });

  Designs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    prompt = json['prompt'] ?? '';
    image = json['image'] ?? '';
    size = json['size'] ?? '';
    quantity = json['quantity'] ?? 0;
    price = json['price'] != null ? json['price'] + 0.00 : 0.00;
    sizeDetail = json['sizeDetail'] ?? '';
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

class SystemProductsSender {
  String? productId;
  int? quantity;
  double? price;
  double? subTotal;
  List<MDVariationData>? variationData;

  SystemProductsSender(
      {this.productId,
      this.quantity,
      this.price,
      this.subTotal,
      this.variationData});

  SystemProductsSender.fromJson(Map<String, dynamic> json) {
    print("json['variationData'] ${json['variationData']}");
    productId = json['productId'] ?? '';
    quantity = json['quantity'] ?? 0;
    price = json['price'] != null ? json['price'] + 0.00 : 0.00;
    subTotal = json['subTotal'] != null ? json['subTotal'] + 0.00 : 0.00;
    if (json['variationData'] != null) {
      variationData = <MDVariationData>[];
      json['variationData'].forEach((v) {
        variationData!.add(new MDVariationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['subTotal'] = this.subTotal;
    data['variationData'] = this.variationData?.map((e) => e.toJson()).toList();
    print("data ${data["variationData"]}");
    return data;
  }
}

class NonSystem {
  String? productId;
  String? variationId;
  List<NonSystemDesigns>? designs;
  int? quantity;
  double? price;
  int? color;
  int? bodyPart;
  double? subTotal;

  NonSystem({
    this.productId,
    this.variationId,
    this.designs,
    this.quantity,
    this.price,
    this.color,
    this.bodyPart,
    this.subTotal,
  });

  NonSystem.fromJson(Map<String, dynamic> json) {
    productId = json['productId'] ?? '';
    variationId = json['variationId'] ?? '';
    if (json['designs'] != null) {
      designs = <NonSystemDesigns>[];
      json['designs'].forEach((v) {
        designs!.add(new NonSystemDesigns.fromJson(v));
      });
    }
    color = json['color'] ?? 0;
    bodyPart = json['bodyPart'] ?? 0;
    subTotal = json['subTotal'] != null ? json['subTotal'] + 0.00 : 0.00;
  }
}

class NonSystemDesigns {
  String? prompt;
  String? image;
  String? size;
  int? quantity;
  double? price;
  String? desireText;
  String? desireTextSizeGroup;
  String? desireTextColorCode;

  NonSystemDesigns({
    this.prompt,
    this.image,
    this.size,
    this.quantity,
    this.price,
    this.desireText,
    this.desireTextSizeGroup,
    this.desireTextColorCode,
  });

  NonSystemDesigns.fromJson(Map<String, dynamic> json) {
    prompt = json['prompt'] ?? '';
    image = json['image'] ?? '';
    size = json['size'] ?? '';
    quantity = json['quantity'] ?? 0;
    price = json['price'] != null ? json['price'] + 0.00 : 0.00;
    desireText = json['desireText'] ?? '';
    desireTextSizeGroup = json['desireTextSizeGroup'] ?? '';
    desireTextColorCode = json['desireTextColorCode'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

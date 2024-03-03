class MDVariationModal {
  int? status;
  String? message;
  MDVariationData? mdVariationData;

  MDVariationModal({this.status, this.message, this.mdVariationData});

  MDVariationModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    mdVariationData = json['data'] != null
        ? new MDVariationData.fromJson(json['data'])
        : null;
  }
}

class MDVariationData {
  String? productId;
  String? prodVariId;
  String? variationId;
  double? price;
  String? color;
  String? size;
  int? variationQuantity;

  MDVariationData({
    this.productId,
    this.prodVariId,
    this.variationId,
    this.price,
    this.color,
    this.size,
    this.variationQuantity,
  });

  // Constructor for deserialization from JSON
  MDVariationData.fromJson(Map<String, dynamic> json) {
    productId = json['productId'] ?? '';
    prodVariId = json['prodVariId'] ?? '';
    variationId = json['variationId'] ?? '';
    price = json['price'] != null
        ? json['price'] is String
            ? double.parse(json['price']) + 0.00
            : json['price'] + 0.00
        : 0.00;
    color = json['color'] ?? '';
    size = json['size'] ?? '';
    variationQuantity = json['variationQuantity'] ?? '';
  }

  // Method to serialize the object into JSON format
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'productId': productId,
      'prodVariId': prodVariId,
      'variationId': variationId,
      'price': price,
      'color': color,
      'size': size,
      'variationQuantity': variationQuantity,
    };
    return data;
  }
}

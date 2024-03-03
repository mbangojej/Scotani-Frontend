import 'package:skincanvas/Models/MDPagination.dart';

class MDProductModal {
  int? status;
  String? message;
  MDProductData? data;

  MDProductModal({this.status, this.message, this.data});

  MDProductModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? new MDProductData.fromJson(json['data']) : null;
  }
}

class MDProductData {
  List<Products>? products;
  Pagination? pagination;

  MDProductData({this.products, this.pagination});

  MDProductData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : Pagination(page: 0, limit: 0, pages: 0, total: 0);
  }
}

class Products {
  String? sId;
  String? title;
  double? price;
  int? quantity;
  int? minQty;
  String? shortDescription;
  String? image;
  bool? isFeatured;
  bool? isProductIntoCart;
  List<Attributes>? attributes;
  List<Variation>? variations;

  Products(
      {this.sId,
      this.title,
      this.price,
      this.shortDescription,
      this.image,
      this.isFeatured,
      this.isProductIntoCart,
      this.quantity,
      this.minQty,
      this.attributes,
      this.variations});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    title = json['title'] ?? '';
    price = json['price'] != null
        ? json['price'] is String
            ? double.parse(json['price']) + 0.00
            : json['price'] + 0.00
        : 0.00;
    minQty = json["minQty"] ?? 0;
    shortDescription = json['shortDescription'] ?? "";
    image = json['image'] ?? '';
    isFeatured = json['isFeatured'] ?? false;
    isProductIntoCart = json['isProductIntoCart'] ?? false;
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }

    if (json['attributes'] != null) {
      final dynamic variationJson = json['attributes'];

      print("Attributes is a list: $variationJson");
      variations = <Variation>[];
      variationJson.forEach((variation) {
        variations!.add(Variation.fromJson(variation));
      });
    }
  }
}

class Attributes {
  List<ColorAndSize>? color;
  List<ColorAndSize>? size;

  Attributes({this.color, this.size});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json['color'] != null) {
      color = <ColorAndSize>[];
      json['color'].forEach((v) {
        color!.add(new ColorAndSize.fromJson(v));
      });
    }
    if (json['size'] != null) {
      size = <ColorAndSize>[];
      json['size'].forEach((v) {
        size!.add(new ColorAndSize.fromJson(v));
      });
    }
  }
}

class ColorAndSize {
  String? sId;
  String? value;
  String? image;

  ColorAndSize({this.sId, this.value, this.image});

  ColorAndSize.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    value = json['value'];
    image = json['image'];
  }
}

class Variation {
  final bool? isColor;
  final bool? isMeasurement;
  final bool? isImage;
  final String? id;
  final String? title;
  final List<Value>? values;

  Variation({
    this.isColor,
    this.isMeasurement,
    this.isImage,
    this.id,
    this.title,
    this.values,
  });

  factory Variation.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Variation();

    return Variation(
      isColor: json['isColor'],
      isMeasurement: json['isMeasurement'],
      isImage: json['isImage'],
      id: json['_id'],
      title: json['title'],
      values: (json['values'] as List?)
          ?.map((value) => Value.fromJson(value))
          .toList(),
    );
  }
}

class Value {
  final String? id;
  final String? title;
  final String? image;
  final String? colorCode;
  final String? measurementScale;

  Value({
    this.id,
    this.title,
    this.image,
    this.colorCode,
    this.measurementScale,
  });

  factory Value.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Value();

    return Value(
      id: json['_id'],
      title: json['title'],
      image: json['image'],
      colorCode: json['colorCode'],
      measurementScale: json['measurementScale'],
    );
  }
}

class MDDesignImprint {
  int? status;
  String? message;
  List<MDDesignImprintData>? mdDesignImprintData;

  MDDesignImprint({this.status, this.message, this.mdDesignImprintData});

  MDDesignImprint.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    message = json['message'] ?? '';
    if (json['data'] != null) {
      mdDesignImprintData = <MDDesignImprintData>[];
      json['data'].forEach((v) {
        mdDesignImprintData!.add(new MDDesignImprintData.fromJson(v));
      });
    }
  }
}

class MDDesignImprintData {
  String? sId;
  String? title;
  double? price;

  MDDesignImprintData({this.sId, this.title, this.price});

  MDDesignImprintData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    title = json['title'] ?? '';
    price = json['price'] !=null ? json['price'] is String? double.parse( json['price'])+0.00 :json['price'] + 0.00 : 0.00;
  }
}

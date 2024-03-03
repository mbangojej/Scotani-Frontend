class MDColorFromSizeModal {
  int? status;
  String? message;
  List<MDColorFromSizeData>? colorFromSizeDataList;

  MDColorFromSizeModal({this.status, this.message, this.colorFromSizeDataList});

  MDColorFromSizeModal.fromJson(Map<String, dynamic> json) {
    status = json['status']??0;
    message = json['message']??'';
    if (json['data'] != null) {
      colorFromSizeDataList = <MDColorFromSizeData>[];
      json['data'].forEach((v) {
        colorFromSizeDataList!.add(new MDColorFromSizeData.fromJson(v));
      });
    }
  }
}

class MDColorFromSizeData {
  String? color;
  String? image;

  MDColorFromSizeData({this.color, this.image});

  MDColorFromSizeData.fromJson(Map<String, dynamic> json) {
    color = json['color']??'';
    image = json['image']??'';
  }

}

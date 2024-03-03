class MDSizeGroup {
  int? status;
  String? message;
  MDSizeGroupData? mdSizeGroupData;

  MDSizeGroup({this.status, this.message, this.mdSizeGroupData});

  MDSizeGroup.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    message = json['message'] ?? '';
    mdSizeGroupData = json['data'] != null
        ? new MDSizeGroupData.fromJson(json['data'])
        : null;
  }
}

class MDSizeGroupData {
  SizeLimits? sizeLimits;
  List<SizeGroups>? sizeGroups;

  MDSizeGroupData({
    this.sizeLimits,
    this.sizeGroups,
  });

  MDSizeGroupData.fromJson(Map<String, dynamic> json) {
    sizeLimits = json['sizeLimits'] != null
        ? new SizeLimits.fromJson(json['sizeLimits'])
        : null;
    if (json['sizeGroups'] != null) {
      sizeGroups = <SizeGroups>[];
      json['sizeGroups'].forEach((v) {
        sizeGroups!.add(new SizeGroups.fromJson(v));
      });
    }
  }
}

class SizeLimits {
  int? start;
  int? end;

  SizeLimits({this.start, this.end});

  SizeLimits.fromJson(Map<String, dynamic> json) {
    start = json['start'] ?? 0;
    end = json['end'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}

class SizeGroups {
  String? sId;
  int? startingWidth;
  int? endingWidth;
  SizeGroupsPrices? prices;

  SizeGroups({this.sId, this.startingWidth, this.endingWidth, this.prices});

  SizeGroups.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    startingWidth = json['startingWidth'] ?? 0;
    endingWidth = json['endingWidth'] ?? 0;
    prices = json['price'] != null
        ? new SizeGroupsPrices.fromJson(json['price'])
        : null;
  }
}

class SizeGroupsPrices {
  double? blackNWhite;
  double? colored;
  double? mixed;

  SizeGroupsPrices({this.blackNWhite, this.colored, this.mixed});

  SizeGroupsPrices.fromJson(Map<String, dynamic> json) {
    blackNWhite = json['blackNWhite'] + 0.00 ?? 0.00;
    colored = json['colored'] + 0.00 ?? 0.00;
    mixed = json['mixed'] + 0.00 ?? 0.00;
  }
}

class SelectedTattoosData {
  double? price;
  String? id;

  SelectedTattoosData({
    this.price,
    this.id,
  });
}

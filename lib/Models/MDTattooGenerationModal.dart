class MDTattooAndGraphicsGenerationModal {
  int? created;
  List<MDTattooGenerationData>? imagesList;

  MDTattooAndGraphicsGenerationModal({this.created, this.imagesList});

  MDTattooAndGraphicsGenerationModal.fromJson(Map<String, dynamic> json) {
    created = json['created'] ?? 0;
    if (json['data'] != null) {
      imagesList = <MDTattooGenerationData>[];
      json['data'].forEach((v) {
        imagesList!.add(new MDTattooGenerationData.fromJson(v));
      });
    }
  }
}

class MDTattooGenerationData {
  String? url;

  MDTattooGenerationData({this.url});

  MDTattooGenerationData.fromJson(Map<String, dynamic> json) {
    url = json['url'] ?? '';
  }
}

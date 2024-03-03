class MDCMSModal {
  int? status;
  String? message;
  MDCMSContent? content;

  MDCMSModal({this.status, this.message, this.content});

  MDCMSModal.fromJson(Map<String, dynamic> json) {
    status = json['status']??0;
    message = json['message']??'';
    content =
    json['content'] != null ?  MDCMSContent.fromJson(json['content']) : MDCMSContent(description: '',sId: '',title: '');
  }

}

class MDCMSContent {
  String? sId;
  String? title;
  String? description;

  MDCMSContent({this.sId, this.title, this.description});

  MDCMSContent.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
  }

}

class KnowledgeBaseResponse {
  int? status;
  List<KnowLedgeData>? data;
  String? message;

  KnowledgeBaseResponse({this.status, this.data});

  KnowledgeBaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <KnowLedgeData>[];
      json['data'].forEach((v) {
        data!.add(KnowLedgeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KnowLedgeData {
  int? id;
  String? title;
  String? description;
  String? category;

  KnowLedgeData({this.id, this.title, this.description, this.category});

  KnowLedgeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['category'] = this.category;
    return data;
  }
}

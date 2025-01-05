class PipelineResponse {
  int? status;
  List<PipeLineData>? data;

  PipelineResponse({this.status, this.data});

  PipelineResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PipeLineData>[];
      json['data'].forEach((v) {
        data!.add(PipeLineData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PipeLineData {
  int? id;
  String? name;
  List<Stages>? stages;

  PipeLineData({this.id, this.name, this.stages});

  PipeLineData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['stages'] != null) {
      stages = <Stages>[];
      json['stages'].forEach((v) {
        stages!.add(Stages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (stages != null) {
      data['stages'] = stages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stages {
  int? id;
  String? name;
  int? order;

  Stages({this.id, this.name, this.order});

  Stages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    return data;
  }
}

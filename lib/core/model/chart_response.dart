class ChartResponse {
  int? status;
  Data? data;
  String? message;
  ChartResponse({this.status, this.data,this.message});

  ChartResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Pipeline>? pipeline;
  List<ChartData>? chartData;

  Data({this.pipeline, this.chartData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['pipeline'] != null) {
      pipeline = <Pipeline>[];
      json['pipeline'].forEach((v) {
        pipeline!.add(new Pipeline.fromJson(v));
      });
    }
    if (json['chartData'] != null) {
      chartData = <ChartData>[];
      json['chartData'].forEach((v) {
        chartData!.add(new ChartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pipeline != null) {
      data['pipeline'] = this.pipeline!.map((v) => v.toJson()).toList();
    }
    if (this.chartData != null) {
      data['chartData'] = this.chartData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pipeline {
  int? id;
  String? name;
  int? createdBy;
  int? workspaceId;
  String? createdAt;
  String? updatedAt;

  Pipeline(
      {this.id,
        this.name,
        this.createdBy,
        this.workspaceId,
        this.createdAt,
        this.updatedAt});

  Pipeline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdBy = json['created_by'];
    workspaceId = json['workspace_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_by'] = this.createdBy;
    data['workspace_id'] = this.workspaceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ChartData {
  String? name;
  int? value;

  ChartData({this.name, this.value});

  ChartData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

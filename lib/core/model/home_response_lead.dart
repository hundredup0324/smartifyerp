import 'package:attendance/core/model/pipeline_response.dart';

class HomeResponse {
  int? status;
  HomeData? data;
  String? message;

  HomeResponse({this.status, this.data,this.message});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HomeData {
  int? totalUsers;
  int? totalLeads;

  List<PipeLineData>? pipeLineData;
  List<LatestLeads>? latestLeads;
  List<ChartData>? chartData;


  HomeData(
      {this.totalUsers, this.totalLeads, this.pipeLineData, this.latestLeads});

  HomeData.fromJson(Map<String, dynamic> json) {
    totalUsers = json['totalUsers'];
    totalLeads = json['totalLeads'];

    if (json['pipelines'] != null) {
      pipeLineData = <PipeLineData>[];
      json['pipelines'].forEach((v) {
        pipeLineData!.add(PipeLineData.fromJson(v));
      });
    }
    if (json['latestLeads'] != null) {
      latestLeads = <LatestLeads>[];
      json['latestLeads'].forEach((v) {
        latestLeads!.add(LatestLeads.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalUsers'] = totalUsers;
    data['totalLeads'] = totalLeads;
    if (pipeLineData != null) {
      data['pipelines'] = pipeLineData!.map((v) => v.toJson()).toList();
    }
    if (latestLeads != null) {
      data['latestLeads'] = latestLeads!.map((v) => v.toJson()).toList();
    }
    if (this.chartData != null) {
      data['chartData'] = this.chartData!.map((v) => v.toJson()).toList();
    }
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


class LatestLeads {
  int? id;
  String? name;
  String? status;
  String? createdAt;

  LatestLeads({this.id, this.name, this.status, this.createdAt});

  LatestLeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}

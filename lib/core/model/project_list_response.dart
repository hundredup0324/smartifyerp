import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectListResponse {
  int? status;
  Data? data;
  String? message;

  ProjectListResponse({this.status, this.data,this.message});

  ProjectListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message']=this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Projects>? projects;

  Data({this.projects});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(new Projects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Projects {
  int? id;
  String? name;
  String? status;
  int? totalComments;
  int?  totalTask;
  String? description;
  String? startDate;
  String? endDate;
  int? createdBy;

  Projects(
      {this.id,
      this.name,
      this.status,
      this.totalComments,
      this.totalTask,
      this.description,
      this.startDate,
      this.endDate,
      this.createdBy});

  Projects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalTask = json['total_task'];
    totalComments = json['total_comments'];
    status = json['status'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['total_comments'] = totalComments;
    data['total_task'] = totalTask;
    data['status'] = status;
    data['description'] = description;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['created_by'] = createdBy;
    return data;
  }
}

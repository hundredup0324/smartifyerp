import 'dart:ffi';

class HomeResponse {
  int? status;
  String? message;

  Data? data;

  HomeResponse({this.status, this.data, this.message});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json["message"];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data["message"] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? totalProject;
  int? totalBugs;
  int? totalTask;
  int? totalMembers;
  Status? status;
  List<Tasks>? tasks;

  Data(
      {this.totalProject,
      this.totalBugs,
      this.totalTask,
      this.totalMembers,
      this.status,
      this.tasks});

  Data.fromJson(Map<String, dynamic> json) {
    totalProject = json['totalProject'];
    totalBugs = json['totalBugs'];
    totalTask = json['totalTask'];
    totalMembers = json['totalMembers'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalProject'] = totalProject;
    data['totalBugs'] = totalBugs;
    data['totalTask'] = totalTask;
    data['totalMembers'] = totalMembers;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  int? ongoing;
  int? finished;
  int? onHold;

  Status({this.ongoing, this.finished, this.onHold});

  Status.fromJson(Map<String, dynamic> json) {
    ongoing = json['Ongoing'];
    finished = json['Finished'];
    onHold = json['OnHold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Ongoing'] = ongoing;
    data['Finished'] = finished;
    data['OnHold'] = onHold;
    return data;
  }
}

class Tasks {
  int? id;
  String? title;
  String? priority;
  String? startDate;
  String? dueDate;
  String? projectName;
  int? projectId;
  String? status;

  Tasks(
      {this.id,
      this.title,
      this.priority,
      this.startDate,
      this.dueDate,
      this.projectName,
      this.projectId,
      this.status});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priority = json['priority'];
    startDate = json['start_date'];
    dueDate = json['due_date'];
    projectName = json['project_name'];
    projectId = json['project_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['priority'] = priority;
    data['start_date'] = startDate;
    data['due_date'] = dueDate;
    data['project_name'] = projectName;
    data['project_id'] = projectId;
    data['status'] = status;
    return data;
  }
}

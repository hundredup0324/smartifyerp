class TaskListResponse {
  int? status;
  List<TaskListData>? data;
  String? message;

  TaskListResponse({this.status, this.data,this.message});

  TaskListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TaskListData>[];
      json['data'].forEach((v) {
        data!.add(TaskListData.fromJson(v));
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

class TaskListData {
  int? id;
  String? name;
  String? color;
  int? complete;
  int? order;
  List<Tasks>? tasks;

  TaskListData({this.id, this.name, this.color, this.complete, this.order, this.tasks});

  TaskListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    complete = json['complete'];
    order = json['order'];
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['complete'] = this.complete;
    data['order'] = this.order;
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
  int? id;
  String? title;
  String? priority;
  String? description;
  String? startDate;
  String? dueDate;
  int? projectId;
  int? milestoneId;
  int? order;
  int? previousStage;
  int? currentStage;
  int? nextStage;
  List<AssignTo>? assignTo;

  Tasks(
      {this.id,
        this.title,
        this.priority,
        this.description,
        this.startDate,
        this.dueDate,
        this.projectId,
        this.milestoneId,
        this.order,
        this.previousStage,
        this.currentStage,
        this.assignTo,
        this.nextStage});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priority = json['priority'];
    description = json['description'];
    startDate = json['start_date'];
    dueDate = json['due_date'];
    projectId = json['project_id'];
    milestoneId = json['milestone_id'];
    order = json['order'];
    previousStage = json['previous_stage'];
    currentStage = json['current_stage'];
    nextStage = json['next_stage'];
    if (json['assign_to'] != null) {
      assignTo = <AssignTo>[];
      json['assign_to'].forEach((v) {
        assignTo!.add(AssignTo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['priority'] = this.priority;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['due_date'] = this.dueDate;
    data['project_id'] = this.projectId;
    data['milestone_id'] = this.milestoneId;
    data['order'] = this.order;
    data['previous_stage'] = this.previousStage;
    data['current_stage'] = this.currentStage;
    data['next_stage'] = this.nextStage;

    if (this.assignTo != null) {
      data['assign_to'] = this.assignTo!.map((v) => v.toJson()).toList();
    }
    return data;
  }




}


class AssignTo {
  int? id;
  String? name;
  String? email;
  String? avatar;

  AssignTo({this.id, this.name, this.email, this.avatar});

  AssignTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    return data;
  }
}
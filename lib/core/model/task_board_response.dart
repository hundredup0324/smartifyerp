class TaskBoardResponse {
  int? status;
  String? message;
  List<TaskBoardData>? data;

  TaskBoardResponse({this.status, this.message, this.data});

  TaskBoardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TaskBoardData>[];
      json['data'].forEach((v) {
        data!.add(TaskBoardData.fromJson(v));
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

class TaskBoardData {
  int? id;
  String? name;
  String? color;
  int? complete;
  int? order;
  List<Tasks>? tasks;

  TaskBoardData(
      {this.id, this.name, this.color, this.complete, this.order, this.tasks});

  TaskBoardData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    complete = json['complete'];
    order = json['order'];
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    data['complete'] = complete;
    data['order'] = order;
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['priority'] = priority;
    data['description'] = description;
    data['start_date'] = startDate;
    data['due_date'] = dueDate;
    data['project_id'] = projectId;
    data['milestone_id'] = milestoneId;
    data['order'] = order;
    data['previous_stage'] = previousStage;
    data['current_stage'] = currentStage;
    data['next_stage'] = nextStage;
    return data;
  }
}

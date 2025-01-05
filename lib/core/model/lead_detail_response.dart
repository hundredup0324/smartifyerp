class LeadDetailResponse {
  int? status;
  Data? data;
  String? message;

  LeadDetailResponse({this.status, this.data});

  LeadDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? id;
  String? name;
  String? email;
  String? subject;
  int? pipelineId;
  String? pipelineName;
  String? stageName;
  String? percentage;
  String? created_at;
  int? stageId;
  int? order;
  String? phone;
  String? followUpDate;
  List<TasksList>? tasksList;
  List<LeadActivity>? leadActivity;

  Data(
      {this.id,
        this.name,
        this.email,
        this.subject,
        this.pipelineId,
        this.pipelineName,
        this.percentage,
        this.created_at,
        this.stageName,
        this.stageId,
        this.order,
        this.phone,
        this.followUpDate,
        this.tasksList,
        this.leadActivity});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    subject = json['subject'];
    pipelineId = json['pipeline_id'];
    pipelineName = json['pipeline_name'];
    percentage = json['percentage'];
    created_at = json['created_at'];
    stageName = json['stage_name'];
    stageId = json['stage_id'];
    order = json['order'];
    phone = json['phone'];
    followUpDate = json['follow_up_date'];
    if (json['tasks_list'] != null) {
      tasksList = <TasksList>[];
      json['tasks_list'].forEach((v) {
        tasksList!.add(TasksList.fromJson(v));
      });
    }
    if (json['lead_activity'] != null) {
      leadActivity = <LeadActivity>[];
      json['lead_activity'].forEach((v) {
        leadActivity!.add(LeadActivity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['subject'] = subject;
    data['pipeline_id'] = pipelineId;
    data['pipeline_name'] = pipelineName;
    data['percentage'] = percentage;
    data['created_at'] = created_at;
    data['stage_id'] = stageId;
    data['stage_name'] = stageName;
    data['order'] = order;
    data['phone'] = phone;
    data['follow_up_date'] = followUpDate;
    if (tasksList != null) {
      data['tasks_list'] = tasksList!.map((v) => v.toJson()).toList();
    }
    if (leadActivity != null) {
      data['lead_activity'] =
          leadActivity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TasksList {
  int? id;
  String? name;
  String? date;
  String? time;
  String? priority;
  String? status;

  TasksList(
      {this.id, this.name, this.date, this.time, this.priority, this.status});

  TasksList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    time = json['time'];
    priority = json['priority'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['date'] = date;
    data['time'] = time;
    data['priority'] = priority;
    data['status'] = status;
    return data;
  }
}

class LeadActivity {
  int? id;
  String? remark;
  String? time;

  LeadActivity({this.id, this.remark, this.time});

  LeadActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    remark = json['remark'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['remark'] = remark;
    data['time'] = time;
    return data;
  }
}

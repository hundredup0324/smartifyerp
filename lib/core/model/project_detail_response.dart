
class ProjectDetailResponse {
  int? status;
  String? message;
  ProjectDetailData? data;

  ProjectDetailResponse({this.status, this.data});

  ProjectDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? ProjectDetailData.fromJson(json['data'])
        : null;
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

class ProjectDetailData {
  int? id;
  String? name;
  String? startDate;
  String? endDate;
  String? status;
  String? projectCopylink;
  int? totalMembers;
  String? description;
  int? daysleft;
  String? budget;
  int? totalTask;
  int? totalComments;
  List<Members>? members;
  List<Clients>? clients;
  List<Milestones>? milestones;

  ProjectDetailData(
      {this.id,
      this.name,
      this.startDate,
      this.endDate,
      this.status,
        this.projectCopylink,
      this.totalMembers,
      this.description,
      this.daysleft,
      this.budget,
      this.totalTask,
      this.totalComments,
      this.members,
      this.clients,
      this.milestones});

  ProjectDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    projectCopylink = json['project_copylink'];
    endDate = json['end_date'];
    status = json['status'];
    totalMembers = json['total_members'];
    description = json['description'];
    daysleft = json['daysleft'];
    budget = json['budget'];
    totalTask = json['total_task'];
    totalComments = json['total_comments'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
    if (json['clients'] != null) {
      clients = <Clients>[];
      json['clients'].forEach((v) {
        clients!.add(Clients.fromJson(v));
      });
    }

    if (json['milestones'] != null) {
      milestones = <Milestones>[];
      json['milestones'].forEach((v) {
        milestones!.add(Milestones.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['project_copylink'] = projectCopylink;
    data['status'] = status;
    data['total_members'] = totalMembers;
    data['description'] = description;
    data['daysleft'] = daysleft;
    data['budget'] = budget;
    data['total_task'] = totalTask;
    data['total_comments'] = totalComments;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    if (clients != null) {
      data['clients'] = clients!.map((v) => v.toJson()).toList();
    }

    if (milestones != null) {
      data['milestones'] = milestones!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  int? id;
  String? name;
  String? email;
  String? avatar;

  Members({this.id, this.name, this.email, this.avatar});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['avatar'] = avatar;
    return data;
  }
}

class Clients {
  int? id;
  String? name;
  String? email;
  String? avatar;

  Clients({this.id, this.name, this.email, this.avatar});

  Clients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['avatar'] = avatar;
    return data;
  }
}

class Milestones {
  int? id;
  int? projectId;
  String? title;
  String? status;
  int? cost;
  String? summary;
  String? progress;
  String? startDate;
  String? endDate;

  Milestones(
      {this.id,
      this.projectId,
      this.title,
      this.status,
      this.cost,
      this.summary,
      this.progress,
      this.startDate,
      this.endDate});

  Milestones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    title = json['title'];
    status = json['status'];
    cost = json['cost'];
    summary = json['summary'];
    progress = json['progress'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_id'] = projectId;
    data['title'] = title;
    data['status'] = status;
    data['cost'] = cost;
    data['summary'] = summary;
    data['progress'] = progress;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}

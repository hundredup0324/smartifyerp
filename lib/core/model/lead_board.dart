// ignore_for_file: prefer_collection_literals

class LeadBoardResponse {
  int? status;
  List<LeadData>? data;

  LeadBoardResponse({this.status, this.data});

  LeadBoardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <LeadData>[];
      json['data'].forEach((v) {
        data!.add(LeadData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeadData {
  int? id;
  String? name;
  int? order;
  List<Leads>? leads;

  LeadData({this.id, this.name, this.order, this.leads});

  LeadData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    if (json['leads'] != null) {
      leads = <Leads>[];
      json['leads'].forEach((v) {
        leads!.add(Leads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    if (leads != null) {
      data['leads'] = leads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leads {
  int? id;
  String? name;
  String? email;
  int? assignUserId;
  String? subject;
  String? phone;
  int? totalProducts;
  int? totalSources;
  String? totalTask;
  String? followUpdate;
  int? order;
  int? previousStage;
  int? currentStage;
  int? nextStage;
  List<Labels>? labels;
  List<Users>? users;

  Leads(
      {this.id,
        this.name,
        this.email,
        this.subject,
        this.order,
        this.previousStage,
        this.currentStage,
        this.nextStage,
        this.assignUserId,
        this.labels,
        this.users});

  Leads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    assignUserId = json['assign_user'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    subject = json['subject'];
    previousStage = json['previous_stage'];
    totalProducts = json['total_products'];
    followUpdate = json['follow_up_date'];
    totalSources = json['total_sources'];
    totalTask = json['total_tasks'];
    currentStage = json['current_stage'];
    nextStage = json['next_stage'];
    if (json['labels'] != null) {
      labels = <Labels>[];
      json['labels'].forEach((v) {
        labels!.add(Labels.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['subject'] = subject;
    data['order'] = order;
    data['assign_user'] = assignUserId;
    data['previous_stage'] = previousStage;
    data['total_products'] = totalProducts;
    data['follow_up_date'] = followUpdate;
    data['total_sources'] = totalSources;
    data['total_tasks'] = totalTask;
    data['current_stage'] = currentStage;
    data['next_stage'] = nextStage;
    if (labels != null) {
      data['labels'] = labels!.map((v) => v.toJson()).toList();
    }
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Labels {
  int? id;
  String? name;
  String? color;

  Labels({this.id, this.name, this.color});

  Labels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? avatar;

  Users({this.id, this.name, this.avatar});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}

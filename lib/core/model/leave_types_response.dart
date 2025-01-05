class LeaveTypesResponse {
  int? status;
  String? message;
  List<LeaveType>? data;

  LeaveTypesResponse({this.status, this.message, this.data});

  LeaveTypesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LeaveType>[];
      json['data'].forEach((v) {
        data!.add(LeaveType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveType {
  int? id;
  String? title;
  int? days;
  int? used;
  int? isDisable;

  LeaveType({this.id, this.title, this.days, this.used, this.isDisable});

  LeaveType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    days = json['days'];
    used = json['used'];
    isDisable = json['is_disable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['days'] = days;
    data['used'] = used;
    data['is_disable'] = isDisable;
    return data;
  }
}
class MyLeavesResponse {
  int? status;
  String? message;
  List<LeaveData>? data;

  MyLeavesResponse({this.status, this.message, this.data});

  MyLeavesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LeaveData>[];
      json['data'].forEach((v) {
        data!.add(new LeaveData.fromJson(v));
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

class LeaveData {
  int? id;
  int? employeeId;
  int? userId;
  int? leaveTypeId;
  String? appliedOn;
  String? startDate;
  String? endDate;
  String? totalLeaveDays;
  String? leaveReason;
  String? remark;
  String? status;
  int? workspace;
  int? createdBy;

  LeaveData(
      {this.id,
        this.employeeId,
        this.userId,
        this.leaveTypeId,
        this.appliedOn,
        this.startDate,
        this.endDate,
        this.totalLeaveDays,
        this.leaveReason,
        this.remark,
        this.status,
        this.workspace,
        this.createdBy});

  LeaveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    userId = json['user_id'];
    leaveTypeId = json['leave_type_id'];
    appliedOn = json['applied_on'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    totalLeaveDays = json['total_leave_days'];
    leaveReason = json['leave_reason'];
    remark = json['remark'];
    status = json['status'];
    workspace = json['workspace'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['user_id'] = this.userId;
    data['leave_type_id'] = this.leaveTypeId;
    data['applied_on'] = this.appliedOn;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['total_leave_days'] = this.totalLeaveDays;
    data['leave_reason'] = this.leaveReason;
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['workspace'] = this.workspace;
    data['created_by'] = this.createdBy;
    return data;
  }
}
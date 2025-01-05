class ClockInResponse {
  int? status;
  String? message;
  Data? data;

  ClockInResponse({this.status, this.message, this.data});

  ClockInResponse.fromJson(Map<String, dynamic> json) {
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
  int? isClockin;
  int? attendenceId;
  String? attendenceClockIn;
  String? clockIn;
  String? clockOut;
  String? totalHours;


  Data({this.isClockin, this.attendenceId, this.attendenceClockIn,this.clockIn,this.clockOut,this.totalHours});

  Data.fromJson(Map<String, dynamic> json) {
    isClockin = json['is_clockin'];
    clockIn = json['clock_in'];
    clockOut = json['clock_out'];
    totalHours = json['total_hours'];
    attendenceId = json['attendence_id'];
    attendenceClockIn = json['attendence_clock_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_clockin'] = isClockin;
    data['clock_in'] = clockIn;
    data['clock_out'] = clockOut;
    data['total_hours'] = totalHours;

    data['attendence_id'] = attendenceId;
    data['attendence_clock_in'] = attendenceClockIn;
    return data;
  }
}
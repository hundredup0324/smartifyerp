class AttendanceHistory {
  int? status;
  List<AttendanceData>? data;

  AttendanceHistory({this.status, this.data});

  AttendanceHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AttendanceData>[];
      json['data'].forEach((v) {
        data!.add(AttendanceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttendanceData {
  String? totalTime;
  String? date;
  List<History>? history;

  AttendanceData({this.totalTime, this.date, this.history});

  AttendanceData.fromJson(Map<String, dynamic> json) {
    totalTime = json['total_time'];
    date = json['date'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total_time'] = totalTime;
    data['date'] = date;
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  int? id;
  String? status;
  String? clockIn;
  String? clockOut;
  String? total;

  History({this.id, this.status, this.clockIn, this.clockOut, this.total});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    clockIn = json['clock_in'];
    clockOut = json['clock_out'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['clock_in'] = clockIn;
    data['clock_out'] = clockOut;
    data['total'] = total;
    return data;
  }
}

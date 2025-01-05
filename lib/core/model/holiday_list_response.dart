class HolidayListResponse {
  int? status;
  String? message;
  List<HolidayData>? data;

  HolidayListResponse({
     this.status,
     this.message,
     this.data,
  });

  HolidayListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HolidayData>[];
      json['data'].forEach((v) {
        data!.add(HolidayData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class HolidayData {
  String? title;
  String? start;
  String? end;
  String? className;

  HolidayData({
     this.title,
     this.start,
     this.end,
     this.className,
  });

  HolidayData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    start = json['start'];
    end = json['end'];
    className = json['className'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['start'] = start;
    data['end'] = end;
    data['className'] = className;
    return data;
  }

}

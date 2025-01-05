class DashboardResponse {
  int? status;
  String? message;
  HomeData? data;

  DashboardResponse({this.status, this.data,this.message});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
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

class HomeData {
  List<YearWiseChart>? yearWiseChart;
  List<ChartDatas>? chartDatas;
  int? totalCategories;
  int? openTicket;
  int? closeTicket;

  HomeData(
      {this.yearWiseChart,
        this.chartDatas,
        this.totalCategories,
        this.openTicket,
        this.closeTicket});

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['YearWiseChart'] != null) {
      yearWiseChart = <YearWiseChart>[];
      json['YearWiseChart'].forEach((v) {
        yearWiseChart!.add(YearWiseChart.fromJson(v));
      });
    }
    if (json['chartDatas'] != null) {
      chartDatas = <ChartDatas>[];
      json['chartDatas'].forEach((v) {
        chartDatas!.add(ChartDatas.fromJson(v));
      });
    }
    totalCategories = json['total_categories'];
    openTicket = json['open_ticket'];
    closeTicket = json['close_ticket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (yearWiseChart != null) {
      data['YearWiseChart'] =
          yearWiseChart!.map((v) => v.toJson()).toList();
    }
    if (chartDatas != null) {
      data['chartDatas'] = chartDatas!.map((v) => v.toJson()).toList();
    }
    data['total_categories'] = totalCategories;
    data['open_ticket'] = openTicket;
    data['close_ticket'] = closeTicket;
    return data;
  }
}

class YearWiseChart {
  String? name;
  int? value;

  YearWiseChart({this.name, this.value});

  YearWiseChart.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

class ChartDatas {
  String? name;
  int? value;
  String? color;

  ChartDatas({this.name, this.value, this.color});

  ChartDatas.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['color'] = color;
    return data;
  }
}

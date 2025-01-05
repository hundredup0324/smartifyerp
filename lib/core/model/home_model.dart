// To parse this JSON data, do
//
//     final home = homeFromJson(jsonString);

import 'dart:convert';

Home homeFromJson(String str) => Home.fromJson(json.decode(str));

String homeToJson(Home data) => json.encode(data.toJson());

class Home {
  int? status;
  String? message;
  HomeData? data;

  Home({
    this.status,
    this.message,
    this.data,
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : HomeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class HomeData {
  UserData? userData;
  Statistics? statistics;
  List<LastTicket>? lastTicket;
  GraphData? graphData;
  List<CategoryAnalytic>? categoryAnalytics;
  TicketAnalytics? ticketAnalytics;

  HomeData({
    this.userData,
    this.statistics,
    this.lastTicket,
    this.graphData,
    this.categoryAnalytics,
    this.ticketAnalytics,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
    userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
    statistics: json["statistics"] == null ? null : Statistics.fromJson(json["statistics"]),
    lastTicket: json["last_ticket"] == null ? [] : List<LastTicket>.from(json["last_ticket"]!.map((x) => LastTicket.fromJson(x))),
    graphData: json["graph_data"] == null ? null : GraphData.fromJson(json["graph_data"]),
    categoryAnalytics: json["category_analytics"] == null ? [] : List<CategoryAnalytic>.from(json["category_analytics"]!.map((x) => CategoryAnalytic.fromJson(x))),
    ticketAnalytics: json["ticket_analytics"] == null ? null : TicketAnalytics.fromJson(json["ticket_analytics"]),
  );

  Map<String, dynamic> toJson() => {
    "user_data": userData?.toJson(),
    "statistics": statistics?.toJson(),
    "last_ticket": lastTicket == null ? [] : List<dynamic>.from(lastTicket!.map((x) => x.toJson())),
    "graph_data": graphData?.toJson(),
    "category_analytics": categoryAnalytics == null ? [] : List<dynamic>.from(categoryAnalytics!.map((x) => x.toJson())),
    "ticket_analytics": ticketAnalytics?.toJson(),
  };
}

class CategoryAnalytic {
  String? category;
  String? color;
  int? value;

  CategoryAnalytic({
    this.category,
    this.color,
    this.value,
  });

  factory CategoryAnalytic.fromJson(Map<String, dynamic> json) => CategoryAnalytic(
    category: json["category"],
    color: json["color"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "color": color,
    "value": value,
  };
}

class GraphData {
  List<String>? xAxis;
  List<YAxi>? yAxis;

  GraphData({
    this.xAxis,
    this.yAxis,
  });

  factory GraphData.fromJson(Map<String, dynamic> json) => GraphData(
    xAxis: json["x_axis"] == null ? [] : List<String>.from(json["x_axis"]!.map((x) => x)),
    yAxis: json["y_axis"] == null ? [] : List<YAxi>.from(json["y_axis"]!.map((x) => YAxi.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "x_axis": xAxis == null ? [] : List<dynamic>.from(xAxis!.map((x) => x)),
    "y_axis": yAxis == null ? [] : List<dynamic>.from(yAxis!.map((x) => x.toJson())),
  };
}

class YAxi {
  String? name;
  String? color;
  List<int>? data;

  YAxi({
    this.name,
    this.color,
    this.data,
  });

  factory YAxi.fromJson(Map<String, dynamic> json) => YAxi(
    name: json["name"],
    color: json["color"],
    data: json["data"] == null ? [] : List<int>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "color": color,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}

class LastTicket {
  int? id;
  String? ticketId;
  String? name;
  String? email;
  String? category;
  String? subject;
  String? status;
  String? description;
  dynamic note;
  List<String>? attachments;
  String? color;
  String? time;

  LastTicket({
    this.id,
    this.ticketId,
    this.name,
    this.email,
    this.category,
    this.subject,
    this.status,
    this.description,
    this.note,
    this.attachments,
    this.color,
    this.time,
  });

  factory LastTicket.fromJson(Map<String, dynamic> json) => LastTicket(
    id: json["id"],
    ticketId: json["ticket_id"],
    name: json["name"],
    email: json["email"],
    category: json["category"],
    subject: json["subject"],
    status: json["status"],
    description: json["description"],
    note: json["note"],
    attachments: json["attachments"] == null ? [] : List<String>.from(json["attachments"]!.map((x) => x)),
    color: json["color"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticket_id": ticketId,
    "name": name,
    "email": email,
    "category": category,
    "subject": subject,
    "status": status,
    "description": description,
    "note": note,
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x)),
    "color": color,
    "time": time,
  };
}

class Statistics {
  int? category;
  int? openTicket;
  int? closeTicket;
  int? agents;

  Statistics({
    this.category,
    this.openTicket,
    this.closeTicket,
    this.agents,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    category: json["category"],
    openTicket: json["open_ticket"],
    closeTicket: json["close_ticket"],
    agents: json["agents"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "open_ticket": openTicket,
    "close_ticket": closeTicket,
    "agents": agents,
  };
}

class TicketAnalytics {
  int? newTicket;
  int? openTicket;
  int? closeTicket;

  TicketAnalytics({
    this.newTicket,
    this.openTicket,
    this.closeTicket,
  });

  factory TicketAnalytics.fromJson(Map<String, dynamic> json) => TicketAnalytics(
    newTicket: json["new_ticket"],
    openTicket: json["open_ticket"],
    closeTicket: json["close_ticket"],
  );

  Map<String, dynamic> toJson() => {
    "new_ticket": newTicket,
    "open_ticket": openTicket,
    "close_ticket": closeTicket,
  };
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? imageUrl;
  int? totalTicket;

  UserData({
    this.id,
    this.name,
    this.email,
    this.imageUrl,
    this.totalTicket,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    imageUrl: json["image_url"],
    totalTicket: json["total_ticket"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image_url": imageUrl,
    "total_ticket": totalTicket,
  };
}

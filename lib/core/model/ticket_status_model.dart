// To parse this JSON data, do
//
//     final ticketStatus = ticketStatusFromJson(jsonString);

import 'dart:convert';

TicketStatus ticketStatusFromJson(String str) =>
    TicketStatus.fromJson(json.decode(str));

String ticketStatusToJson(TicketStatus data) => json.encode(data.toJson());

class TicketStatus {
  int? status;
  String? message;
  TicketStatusData? data;

  TicketStatus({
    this.status,
    this.message,
    this.data,
  });

  factory TicketStatus.fromJson(Map<String, dynamic> json) => TicketStatus(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : TicketStatusData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class TicketStatusData {
  List<Status>? status;

  TicketStatusData({
    this.status,
  });

  factory TicketStatusData.fromJson(Map<String, dynamic> json) =>
      TicketStatusData(
        status: json["status"] == null
            ? []
            : List<Status>.from(json["status"]!.map((x) => Status.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null
            ? []
            : List<dynamic>.from(status!.map((x) => x.toJson())),
      };
}

class Status {
  String? name;

  Status({
    this.name,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

// To parse this JSON data, do
//
//     final ticketsModel = ticketsModelFromJson(jsonString);

import 'dart:convert';

TicketsModel ticketsModelFromJson(String str) =>
    TicketsModel.fromJson(json.decode(str));

String ticketsModelToJson(TicketsModel data) => json.encode(data.toJson());

class TicketsModel {
  int? status;
  String? message;
  List<TicketData>? data;

  TicketsModel({
    this.status,
    this.message,
    this.data,
  });

  factory TicketsModel.fromJson(Map<String, dynamic> json) => TicketsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TicketData>.from(
                json["data"]!.map((x) => TicketData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "tickets": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TicketData {
  int? id;
  String? ticketId;
  String? name;
  String? email;
  String? category_name;
  String? account_type;
  String? subject;
  String? status;
  String? description;
  String? note;
  String? color;

  TicketData({
    this.id,
    this.ticketId,
    this.name,
    this.email,
    this.category_name,
    this.account_type,
    this.subject,
    this.status,
    this.description,
    this.note,
    this.color,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) => TicketData(
        id: json["id"],
        ticketId: json["ticket_id"],
        name: json["name"],
        email: json["email"],
        category_name: json["category_name"],
        account_type: json["account_type"],
        subject: json["subject"],
        status: json["status"],
        description: json["description"],
        note: json["note"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ticket_id": ticketId,
        "name": name,
        "email": email,
        "category": category_name,
        "account_type": account_type,
        "subject": subject,
        "status": status,
        "description": description,
        "note": note,
        "color": color,
      };
}

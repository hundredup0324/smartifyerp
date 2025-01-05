// To parse this JSON data, do
//
//     final userRole = userRoleFromJson(jsonString);

import 'dart:convert';

UserRole userRoleFromJson(String str) => UserRole.fromJson(json.decode(str));

String userRoleToJson(UserRole data) => json.encode(data.toJson());

class UserRole {
  int? status;
  String? message;
  UserRoleData? data;

  UserRole({
    this.status,
    this.message,
    this.data,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : UserRoleData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class UserRoleData {
  List<Role>? role;

  UserRoleData({
    this.role,
  });

  factory UserRoleData.fromJson(Map<String, dynamic> json) => UserRoleData(
    role: json["role"] == null ? [] : List<Role>.from(json["role"]!.map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "role": role == null ? [] : List<dynamic>.from(role!.map((x) => x.toJson())),
  };
}

class Role {
  int? id;
  String? name;
  String? guardName;
  DateTime? createdAt;
  DateTime? updatedAt;

  Role({
    this.id,
    this.name,
    this.guardName,
    this.createdAt,
    this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    guardName: json["guard_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "guard_name": guardName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

// To parse this JSON data, do
//
//     final getCustomField = getCustomFieldFromJson(jsonString);

import 'dart:convert';

GetCustomField getCustomFieldFromJson(String str) => GetCustomField.fromJson(json.decode(str));

String getCustomFieldToJson(GetCustomField data) => json.encode(data.toJson());

class GetCustomField {
  int? status;
  String? message;
  GetCustomFieldData? data;

  GetCustomField({
    this.status,
    this.message,
    this.data,
  });

  factory GetCustomField.fromJson(Map<String, dynamic> json) => GetCustomField(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : GetCustomFieldData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class GetCustomFieldData {
  List<CustomField>? customFields;

  GetCustomFieldData({
    this.customFields,
  });

  factory GetCustomFieldData.fromJson(Map<String, dynamic> json) => GetCustomFieldData(
    customFields: json["custom_fields"] == null ? [] : List<CustomField>.from(json["custom_fields"]!.map((x) => CustomField.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "custom_fields": customFields == null ? [] : List<dynamic>.from(customFields!.map((x) => x.toJson())),
  };
}

class CustomField {
  int? id;
  String? name;
  String? type;
  String? placeholder;

  CustomField({
    this.id,
    this.name,
    this.type,
    this.placeholder,
  });

  factory CustomField.fromJson(Map<String, dynamic> json) => CustomField(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    placeholder: json["placeholder"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "placeholder": placeholder,
  };
}

// To parse this JSON data, do
//
//     final allCategory = allCategoryFromJson(jsonString);

import 'dart:convert';

AllCategory allCategoryFromJson(String str) => AllCategory.fromJson(json.decode(str));

String allCategoryToJson(AllCategory data) => json.encode(data.toJson());

class AllCategory {
  int? status;
  String? message;
  AllCategoryData? data;

  AllCategory({
    this.status,
    this.message,
    this.data,
  });

  factory AllCategory.fromJson(Map<String, dynamic> json) => AllCategory(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : AllCategoryData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class AllCategoryData {
  List<Category>? category;

  AllCategoryData({
    this.category,
  });

  factory AllCategoryData.fromJson(Map<String, dynamic> json) => AllCategoryData(
    category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
  };
}

class Category {
  int? id;
  String? name;
  String? color;

  Category({
    this.id,
    this.name,
    this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "color": color,
  };
}

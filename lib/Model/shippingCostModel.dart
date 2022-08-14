// To parse this JSON data, do
//
//     final categoryCostModel = categoryCostModelFromJson(jsonString);

import 'dart:convert';

CategoryCostModel categoryCostModelFromJson(String str) =>
    CategoryCostModel.fromJson(json.decode(str));

String categoryCostModelToJson(CategoryCostModel data) =>
    json.encode(data.toJson());

class CategoryCostModel {
  CategoryCostModel({
    required this.allCategoryShippingCost,
  });

  List<AllCategoryShippingCost> allCategoryShippingCost;

  factory CategoryCostModel.fromJson(Map<String, dynamic> json) =>
      CategoryCostModel(
        allCategoryShippingCost: List<AllCategoryShippingCost>.from(
            json["all_category_shipping_cost"]
                .map((x) => AllCategoryShippingCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all_category_shipping_cost":
            List<dynamic>.from(allCategoryShippingCost.map((x) => x.toJson())),
      };
}

class AllCategoryShippingCost {
  AllCategoryShippingCost({
    required this.id,
    required this.sellerId,
    required this.categoryId,
    required this.cost,
    required this.multiplyQty,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });

  int id;
  int sellerId;
  int categoryId;
  double cost;
  dynamic multiplyQty;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic category;

  factory AllCategoryShippingCost.fromJson(Map<String, dynamic> json) =>
      AllCategoryShippingCost(
        id: json["id"],
        sellerId: json["seller_id"],
        categoryId: json["category_id"],
        cost: json["cost"].toDouble(),
        multiplyQty: json["multiply_qty"] == null ? null : json["multiply_qty"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seller_id": sellerId,
        "category_id": categoryId,
        "cost": cost,
        "multiply_qty": multiplyQty == null ? null : multiplyQty,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category == null ? null : category!.toJson(),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.parentId,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    required this.homeStatus,
    required this.priority,
    required this.translations,
  });

  int id;
  String name;
  String slug;
  String icon;
  int parentId;
  int position;
  DateTime createdAt;
  DateTime updatedAt;
  int homeStatus;
  int priority;
  List<dynamic> translations;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        icon: json["icon"],
        parentId: json["parent_id"],
        position: json["position"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        homeStatus: json["home_status"],
        priority: json["priority"],
        translations: List<dynamic>.from(json["translations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "icon": icon,
        "parent_id": parentId,
        "position": position,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "home_status": homeStatus,
        "priority": priority,
        "translations": List<dynamic>.from(translations.map((x) => x)),
      };
}

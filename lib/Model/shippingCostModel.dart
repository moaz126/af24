
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
}

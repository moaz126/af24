class CategoryModel {
  CategoryModel({
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
    required this.subCategories,
    required this.translations,
  });

  int id;
  String name;
  String slug;
  String? icon;
  int parentId;
  int position;
  DateTime createdAt;
  DateTime updatedAt;
  int homeStatus;
  int priority;
  List<CategoryModel> subCategories;
  List<dynamic> translations;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        icon: json["icon"] == null ? null : json["icon"],
        parentId: json["parent_id"],
        position: json["position"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        homeStatus: json["home_status"],
        priority: json["priority"],
        subCategories: json.containsKey("subCategories")
            ? List<CategoryModel>.from(
                json["subCategories"].map((x) => CategoryModel.fromJson(x)))
            : [],
        translations: List<dynamic>.from(json["translations"].map((x) => x)),
      );
}


class StockOutModel {
  StockOutModel({
    required this.totalSize,
    required this.limit,
    required this.offset,
    required this.products,
  });

  int totalSize;
  int limit;
  int offset;
  List<dynamic> products;

  factory StockOutModel.fromJson(Map<String, dynamic> json) => StockOutModel(
        totalSize: json["total_size"],
        limit: json["limit"],
        offset: json["offset"],
        products: List<dynamic>.from(json["products"].map((x) => x)),
      );

}

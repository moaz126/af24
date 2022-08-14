// To parse this JSON data, do
//
//     final stockOutModel = stockOutModelFromJson(jsonString);

import 'dart:convert';

StockOutModel stockOutModelFromJson(String str) =>
    StockOutModel.fromJson(json.decode(str));

String stockOutModelToJson(StockOutModel data) => json.encode(data.toJson());

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

  Map<String, dynamic> toJson() => {
        "total_size": totalSize,
        "limit": limit,
        "offset": offset,
        "products": List<dynamic>.from(products.map((x) => x)),
      };
}

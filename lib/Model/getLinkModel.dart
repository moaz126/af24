// To parse required this JSON data, do
//
//     final getlinkModel = getlinkModelFromJson(jsonString);

import 'dart:convert';

List<GetlinkModel> getlinkModelFromJson(String str) => List<GetlinkModel>.from(
    json.decode(str).map((x) => GetlinkModel.fromJson(x)));

String getlinkModelToJson(List<GetlinkModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetlinkModel {
  GetlinkModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.sellerId,
    required this.quantity,
    required this.price,
    required this.color,
    required this.size,
    required this.priceSetBySeller,
    required this.seenBySeller,
    required this.generatedLink,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.requestStatus,
  });

  int id;
  int productId;
  int userId;
  int sellerId;
  int quantity;
  dynamic price;
  String color;
  String? size;
  dynamic priceSetBySeller;
  int seenBySeller;
  dynamic generatedLink;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  String? userName;
  String requestStatus;

  factory GetlinkModel.fromJson(Map<String, dynamic> json) => GetlinkModel(
        id: json["id"],
        productId: json["product_id"],
        userId: json["user_id"],
        sellerId: json["seller_id"],
        quantity: json["quantity"],
        price: json["price"],
        color: json["color"],
        size: json["size"],
        priceSetBySeller: json["price_set_by_seller"],
        seenBySeller: json["seen_by_seller"],
        generatedLink: json["generated_link"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userName: json["user_name"],
        requestStatus: json["request_status"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "seller_id": sellerId,
        "quantity": quantity,
        "price": price,
        "color": color,
        "size": size,
        "price_set_by_seller": priceSetBySeller,
        "seen_by_seller": seenBySeller,
        "generated_link": generatedLink,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

// To parse required this JSON data, do
//
//     final getSecretModel = getSecretModelFromJson(jsonString);

import 'dart:convert';

List<GetSecretModel> getSecretModelFromJson(String str) =>
    List<GetSecretModel>.from(
        json.decode(str).map((x) => GetSecretModel.fromJson(x)));

String getSecretModelToJson(List<GetSecretModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSecretModel {
  GetSecretModel({
    this.id,
    this.userId,
    this.sellerId,
    this.productId,
    required this.sendBy,
    required this.message,
    this.createdAt,
    this.updatedAt,
    required this.sellerName,
    this.userName,
  });

  int? id;
  int? userId;
  int? sellerId;
  int? productId;
  String? sendBy;
  String message;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? sellerName;
  String? userName;

  factory GetSecretModel.fromJson(Map<String, dynamic> json) => GetSecretModel(
        id: json["id"],
        userId: json["user_id"],
        sellerId: json["seller_id"],
        productId: json["product_id"],
        sendBy: json["send_by"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sellerName: json["shop_name"],
        userName: json["user_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "seller_id": sellerId,
        "product_id": productId,
        "send_by": sendBy,
        "message": message,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

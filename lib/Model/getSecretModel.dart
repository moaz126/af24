// To parse required this JSON data, do
//
//     final getSecretModel = getSecretModelFromJson(jsonString);

import 'dart:convert';

List<GetSecretModel> getSecretModelFromJson(String str) => List<GetSecretModel>.from(json.decode(str).map((x) => GetSecretModel.fromJson(x)));

String getSecretModelToJson(List<GetSecretModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSecretModel {
    GetSecretModel({
         this.id,
         this.userId,
         this.sellerId,
         this.productId,
        required this.senderName,
        required this.message,
         this.createdAt,
         this.updatedAt,
    });

    int? id;
    int? userId;
    int? sellerId;
    int? productId;
    String senderName;
    String message;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory GetSecretModel.fromJson(Map<String, dynamic> json) => GetSecretModel(
        id: json["id"],
        userId: json["user_id"],
        sellerId: json["seller_id"],
        productId: json["product_id"],
        senderName: json["sender_name"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "seller_id": sellerId,
        "product_id": productId,
        "sender_name": senderName,
        "message": message,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}

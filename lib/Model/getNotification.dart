// To parse required this JSON data, do
//
//     final getNotificationModel = getNotificationModelFromJson(jsonString);

import 'dart:convert';

List<GetNotificationModel> getNotificationModelFromJson(String str) =>
    List<GetNotificationModel>.from(
        json.decode(str).map((x) => GetNotificationModel.fromJson(x)));

String getNotificationModelToJson(List<GetNotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetNotificationModel {
  GetNotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.status,
    required this.userId,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.orderId,
    required this.customerId,
    required this.productId,
  });

  int id;
  String title;
  String description;
  dynamic image;
  int status;
  int userId;
  String type;
  String orderId;
  String customerId;
  String? productId;
  dynamic createdAt;
  dynamic updatedAt;

  factory GetNotificationModel.fromJson(Map<String, dynamic> json) =>
      GetNotificationModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        status: json["seen"],
        userId: json["user_id"],
        type: json["type"],
        createdAt: json["created_at"],
        productId: json["product_id"],
        updatedAt: json["updated_at"],
        orderId: json["order_id"].toString(),
        customerId: json["customer_id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "status": status,
        "user_id": userId,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "product_id": productId,
      };
}

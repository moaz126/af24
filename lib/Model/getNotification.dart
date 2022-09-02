// To parse required this JSON data, do
//
//     final getNotificationModel = getNotificationModelFromJson(jsonString);

import 'dart:convert';

List<GetNotificationModel> getNotificationModelFromJson(String str) => List<GetNotificationModel>.from(json.decode(str).map((x) => GetNotificationModel.fromJson(x)));

String getNotificationModelToJson(List<GetNotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    });

    int id;
    String title;
    String description;
    dynamic image;
    int status;
    int userId;
    String type;
    dynamic createdAt;
    dynamic updatedAt;

    factory GetNotificationModel.fromJson(Map<String, dynamic> json) => GetNotificationModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
        userId: json["user_id"],
        type: json["type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
    };
}

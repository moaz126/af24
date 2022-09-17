// To parse this JSON data, do
//
//     final shopinfoModel = shopinfoModelFromJson(jsonString);

import 'dart:convert';

shopinfoModel shopinfoModelFromJson(String str) =>
    shopinfoModel.fromJson(json.decode(str));

String shopinfoModelToJson(shopinfoModel data) => json.encode(data.toJson());

class shopinfoModel {
  shopinfoModel({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.address,
    required this.contact,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.banner,
    required this.rating,
    required this.ratingCount,
    required this.email,
  });

  int id;
  int sellerId;
  String name;
  String address;
  String contact;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  String banner;
  int rating;
  int ratingCount;
  String email;

  factory shopinfoModel.fromJson(Map<String, dynamic> json) => shopinfoModel(
        id: json["id"],
        sellerId: json["seller_id"],
        email: json["email"],
        name: json["name"],
        address: json["address"],
        contact: json["contact"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        banner: json["banner"],
        rating: json["rating"],
        ratingCount: json["rating_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seller_id": sellerId,
        "name": name,
        "address": address,
        "contact": contact,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "banner": banner,
        "rating": rating,
        "rating_count": ratingCount,
      };
}

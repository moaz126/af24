// To parse this JSON data, do
//
//     final getBrandModel = getBrandModelFromJson(jsonString);

import 'dart:convert';

List<GetBrandModel> getBrandModelFromJson(String str) =>
    List<GetBrandModel>.from(
        json.decode(str).map((x) => GetBrandModel.fromJson(x)));

String getBrandModelToJson(List<GetBrandModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBrandModel {
  GetBrandModel({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.translations,
  });

  int id;
  String name;
  String image;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> translations;

  factory GetBrandModel.fromJson(Map<String, dynamic> json) => GetBrandModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        translations: List<dynamic>.from(json["translations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "translations": List<dynamic>.from(translations.map((x) => x)),
      };
}

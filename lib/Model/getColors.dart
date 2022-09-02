// To parse required this JSON data, do
//
//     final colorsModel = colorsModelFromJson(jsonString);

import 'dart:convert';

List<ColorsModel> colorsModelFromJson(String str) => List<ColorsModel>.from(json.decode(str).map((x) => ColorsModel.fromJson(x)));

String colorsModelToJson(List<ColorsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ColorsModel {
    ColorsModel({
        required this.id,
        required this.name,
        required this.code,
    });

    int id;
    String name;
    String code;

    factory ColorsModel.fromJson(Map<String, dynamic> json) => ColorsModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
    };
}

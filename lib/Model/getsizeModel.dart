// To parse required this JSON data, do
//
//     final sizeModel = sizeModelFromJson(jsonString);

import 'dart:convert';

List<SizeModel> sizeModelFromJson(String str) => List<SizeModel>.from(json.decode(str).map((x) => SizeModel.fromJson(x)));

String sizeModelToJson(List<SizeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SizeModel {
    SizeModel({
         this.id,
        required this.label,
    });

    int? id;
    String label;

    factory SizeModel.fromJson(Map<String, dynamic> json) => SizeModel(
        id: json["id"],
        label: json["label"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
    };
}

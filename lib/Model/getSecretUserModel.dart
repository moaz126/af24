// To parse required this JSON data, do
//
//     final getSecretUser = getSecretUserFromJson(jsonString);

import 'dart:convert';

List<GetSecretUser> getSecretUserFromJson(String str) =>
    List<GetSecretUser>.from(
        json.decode(str).map((x) => GetSecretUser.fromJson(x)));

String getSecretUserToJson(List<GetSecretUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSecretUser {
  GetSecretUser({
    required this.fName,
    required this.lName,
    required this.id,
    required this.image,
    required this.lastMessage,
    required this.messagesCount,
  });

  String fName;
  String lName;
  int id;
  String image;
  DateTime lastMessage;
  int messagesCount;

  factory GetSecretUser.fromJson(Map<String, dynamic> json) => GetSecretUser(
        fName: json["f_name"],
        lName: json["l_name"],
        id: json["id"],
        image: json["image"],
        lastMessage: DateTime.parse(json["last_message"]),
        messagesCount: json["messages_count"],
      );

  Map<String, dynamic> toJson() => {
        "f_name": fName,
        "l_name": lName,
        "id": id,
        "image": image,
      };
}

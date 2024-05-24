// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelLogin modelLoginFromJson(String str) =>
    ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
  int value;
  String message;
  String username;
  String email;
  String id;
  String isAdmin;

  ModelLogin({
    required this.value,
    required this.message,
    required this.username,
    required this.email,
    required this.id,
    required this.isAdmin,
  });

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
        value: json["value"],
        message: json["message"],
        username: json["username"],
        email: json["email"],
        id: json["id"],
        isAdmin: json["is_admin"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
        "username": username,
        "email": email,
        "id": id,
        "is_admin": isAdmin,
      };
}

// To parse this JSON data, do
//
//     final modelUpdateUser = modelUpdateUserFromJson(jsonString);

import 'dart:convert';

ModelUpdateUser modelUpdateUserFromJson(String str) => ModelUpdateUser.fromJson(json.decode(str));

String modelUpdateUserToJson(ModelUpdateUser data) => json.encode(data.toJson());

class ModelUpdateUser {
    bool isSuccess;
    int value;
    String message;
    String username;
    String idUser;

    ModelUpdateUser({
        required this.isSuccess,
        required this.value,
        required this.message,
        required this.username,
        required this.idUser,
    });

    factory ModelUpdateUser.fromJson(Map<String, dynamic> json) => ModelUpdateUser(
        isSuccess: json["is_success"],
        value: json["value"],
        message: json["message"],
        username: json["username"],
        idUser: json["id_user"],
    );

    Map<String, dynamic> toJson() => {
        "is_success": isSuccess,
        "value": value,
        "message": message,
        "username": username,
        "id_user": idUser,
    };
}

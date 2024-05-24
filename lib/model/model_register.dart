// To parse this JSON data, do
//
//     final modelRegister = modelRegisterFromJson(jsonString);

import 'dart:convert';

ModelRegister modelRegisterFromJson(String str) => ModelRegister.fromJson(json.decode(str));

String modelRegisterToJson(ModelRegister data) => json.encode(data.toJson());

class ModelRegister {
    int value;
    String username;
    String email;
    String alamat;
    String noTlp;
    String nik;
    String message;

    ModelRegister({
        required this.value,
        required this.username,
        required this.email,
        required this.alamat,
        required this.noTlp,
        required this.nik,
        required this.message,
    });

    factory ModelRegister.fromJson(Map<String, dynamic> json) => ModelRegister(
        value: json["value"],
        username: json["username"],
        email: json["email"],
        alamat: json["alamat"],
        noTlp: json["no_tlp"],
        nik: json["nik"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "username": username,
        "email": email,
        "alamat": alamat,
        "no_tlp": noTlp,
        "nik": nik,
        "message": message,
    };
}

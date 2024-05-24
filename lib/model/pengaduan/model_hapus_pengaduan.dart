// To parse this JSON data, do
//
//     final modelHapusPengaduan = modelHapusPengaduanFromJson(jsonString);

import 'dart:convert';

ModelHapusPengaduan modelHapusPengaduanFromJson(String str) =>
    ModelHapusPengaduan.fromJson(json.decode(str));

String modelHapusPengaduanToJson(ModelHapusPengaduan data) =>
    json.encode(data.toJson());

class ModelHapusPengaduan {
  String status;
  String message;

  ModelHapusPengaduan({
    required this.status,
    required this.message,
  });

  factory ModelHapusPengaduan.fromJson(Map<String, dynamic> json) =>
      ModelHapusPengaduan(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

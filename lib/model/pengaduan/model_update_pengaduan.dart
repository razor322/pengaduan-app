// To parse this JSON data, do
//
//     final modelUpdatePengaduan = modelUpdatePengaduanFromJson(jsonString);

import 'dart:convert';

ModelUpdatePengaduan modelUpdatePengaduanFromJson(String str) =>
    ModelUpdatePengaduan.fromJson(json.decode(str));

String modelUpdatePengaduanToJson(ModelUpdatePengaduan data) =>
    json.encode(data.toJson());

class ModelUpdatePengaduan {
  bool isSuccess;
  String message;

  ModelUpdatePengaduan({
    required this.isSuccess,
    required this.message,
  });

  factory ModelUpdatePengaduan.fromJson(Map<String, dynamic> json) =>
      ModelUpdatePengaduan(
        isSuccess: json["isSuccess"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
      };
}

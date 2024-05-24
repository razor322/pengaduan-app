// To parse this JSON data, do
//
//     final modelDeleteSejarah = modelDeleteSejarahFromJson(jsonString);

import 'dart:convert';

ModelDeleteSejarah modelDeleteSejarahFromJson(String str) =>
    ModelDeleteSejarah.fromJson(json.decode(str));

String modelDeleteSejarahToJson(ModelDeleteSejarah data) =>
    json.encode(data.toJson());

class ModelDeleteSejarah {
  String status;
  String message;

  ModelDeleteSejarah({
    required this.status,
    required this.message,
  });

  factory ModelDeleteSejarah.fromJson(Map<String, dynamic> json) =>
      ModelDeleteSejarah(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

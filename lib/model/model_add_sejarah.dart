// To parse this JSON data, do
//
//     final modelAddSejarah = modelAddSejarahFromJson(jsonString);

import 'dart:convert';

ModelAddSejarah modelAddSejarahFromJson(String str) =>
    ModelAddSejarah.fromJson(json.decode(str));

String modelAddSejarahToJson(ModelAddSejarah data) =>
    json.encode(data.toJson());

class ModelAddSejarah {
  bool isSuccess;
  String message;

  ModelAddSejarah({
    required this.isSuccess,
    required this.message,
  });

  factory ModelAddSejarah.fromJson(Map<String, dynamic> json) =>
      ModelAddSejarah(
        isSuccess: json["isSuccess"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
      };
}

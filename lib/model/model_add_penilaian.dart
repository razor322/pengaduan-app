// To parse this JSON data, do
//
//     final modelAddPenilaian = modelAddPenilaianFromJson(jsonString);

import 'dart:convert';

ModelAddPenilaian modelAddPenilaianFromJson(String str) =>
    ModelAddPenilaian.fromJson(json.decode(str));

String modelAddPenilaianToJson(ModelAddPenilaian data) =>
    json.encode(data.toJson());

class ModelAddPenilaian {
  bool isSuccess;
  String message;

  ModelAddPenilaian({
    required this.isSuccess,
    required this.message,
  });

  factory ModelAddPenilaian.fromJson(Map<String, dynamic> json) =>
      ModelAddPenilaian(
        isSuccess: json["isSuccess"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
      };
}

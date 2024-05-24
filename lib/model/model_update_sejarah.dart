// To parse this JSON data, do
//
//     final modelUpdateSejarah = modelUpdateSejarahFromJson(jsonString);

import 'dart:convert';

ModelUpdateSejarah modelUpdateSejarahFromJson(String str) =>
    ModelUpdateSejarah.fromJson(json.decode(str));

String modelUpdateSejarahToJson(ModelUpdateSejarah data) =>
    json.encode(data.toJson());

class ModelUpdateSejarah {
  bool isSuccess;
  int value;
  String message;
  String nama;
  DateTime tglLahir;
  String asal;
  String jenisKelamin;
  String deskripsi;

  ModelUpdateSejarah({
    required this.isSuccess,
    required this.value,
    required this.message,
    required this.nama,
    required this.tglLahir,
    required this.asal,
    required this.jenisKelamin,
    required this.deskripsi,
  });

  factory ModelUpdateSejarah.fromJson(Map<String, dynamic> json) =>
      ModelUpdateSejarah(
        isSuccess: json["is_success"],
        value: json["value"],
        message: json["message"],
        nama: json["nama"],
        tglLahir: DateTime.parse(json["tgl_lahir"]),
        asal: json["asal"],
        jenisKelamin: json["jenis_kelamin"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "is_success": isSuccess,
        "value": value,
        "message": message,
        "nama": nama,
        "tgl_lahir":
            "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
        "asal": asal,
        "jenis_kelamin": jenisKelamin,
        "deskripsi": deskripsi,
      };
}

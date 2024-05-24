// To parse this JSON data, do
//
//     final modelListSejarah = modelListSejarahFromJson(jsonString);

import 'dart:convert';

ModelListSejarah modelListSejarahFromJson(String str) =>
    ModelListSejarah.fromJson(json.decode(str));

String modelListSejarahToJson(ModelListSejarah data) =>
    json.encode(data.toJson());

class ModelListSejarah {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelListSejarah({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelListSejarah.fromJson(Map<String, dynamic> json) =>
      ModelListSejarah(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String nama;
  String gambar;
  String tglLahir;
  String asal;
  String jenisKelamin;
  String deskripsi;

  Datum({
    required this.id,
    required this.nama,
    required this.gambar,
    required this.tglLahir,
    required this.asal,
    required this.jenisKelamin,
    required this.deskripsi,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nama: json["nama"],
        gambar: json["gambar"],
        tglLahir: json["tgl_lahir"],
        asal: json["asal"],
        jenisKelamin: json["jenis_kelamin"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "gambar": gambar,
        "tgl_lahir": tglLahir,
        "asal": asal,
        "jenis_kelamin": jenisKelamin,
        "deskripsi": deskripsi,
      };
}

// To parse this JSON data, do
//
//     final modelListPengaduan = modelListPengaduanFromJson(jsonString);

import 'dart:convert';

ModelListPengaduan modelListPengaduanFromJson(String str) =>
    ModelListPengaduan.fromJson(json.decode(str));

String modelListPengaduanToJson(ModelListPengaduan data) =>
    json.encode(data.toJson());

class ModelListPengaduan {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelListPengaduan({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelListPengaduan.fromJson(Map<String, dynamic> json) =>
      ModelListPengaduan(
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
  String noHp;
  String noKtp;
  String fotoKtp;
  String laporan;
  String fotoLaporan;
  String kategori;
  String status;
  String idUser;

  Datum({
    required this.id,
    required this.nama,
    required this.noHp,
    required this.noKtp,
    required this.fotoKtp,
    required this.laporan,
    required this.fotoLaporan,
    required this.kategori,
    required this.status,
    required this.idUser,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nama: json["nama"],
        noHp: json["no_hp"],
        noKtp: json["no_ktp"],
        fotoKtp: json["foto_ktp"],
        laporan: json["laporan"],
        fotoLaporan: json["foto_laporan"],
        kategori: json["kategori"],
        status: json["status"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "no_hp": noHp,
        "no_ktp": noKtp,
        "foto_ktp": fotoKtp,
        "laporan": laporan,
        "foto_laporan": fotoLaporan,
        "kategori": kategori,
        "status": status,
        "id_user": idUser,
      };
}

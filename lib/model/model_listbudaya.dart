// To parse this JSON data, do
//
//     final modelListbudaya = modelListbudayaFromJson(jsonString);

import 'dart:convert';

ModelListbudaya modelListbudayaFromJson(String str) => ModelListbudaya.fromJson(json.decode(str));

String modelListbudayaToJson(ModelListbudaya data) => json.encode(data.toJson());

class ModelListbudaya {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelListbudaya({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelListbudaya.fromJson(Map<String, dynamic> json) => ModelListbudaya(
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
    String judul;
    String konten;
    String gambar;

    Datum({
        required this.id,
        required this.judul,
        required this.konten,
        required this.gambar,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        judul: json["judul"],
        konten: json["konten"],
        gambar: json["gambar"],
    );

  get author => null;

  get created => null;

    Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "konten": konten,
        "gambar": gambar,
    };
}

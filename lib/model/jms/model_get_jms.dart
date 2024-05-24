// To parse this JSON data, do
//
//     final modelAddJms = modelAddJmsFromJson(jsonString);

import 'dart:convert';

ModelAddJms modelAddJmsFromJson(String str) =>
    ModelAddJms.fromJson(json.decode(str));

String modelAddJmsToJson(ModelAddJms data) => json.encode(data.toJson());

class ModelAddJms {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelAddJms({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelAddJms.fromJson(Map<String, dynamic> json) => ModelAddJms(
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
  String sekolah;
  String nama;
  String status;
  String idUser;

  Datum({
    required this.id,
    required this.sekolah,
    required this.nama,
    required this.status,
    required this.idUser,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sekolah: json["sekolah"],
        nama: json["nama"],
        status: json["status"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sekolah": sekolah,
        "nama": nama,
        "status": status,
        "id_user": idUser,
      };
}

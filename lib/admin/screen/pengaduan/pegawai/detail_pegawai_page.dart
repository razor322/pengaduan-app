import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pengaduan_app/const.dart';
import 'package:pengaduan_app/model/admin/model_update_status.dart';
import 'package:pengaduan_app/model/pengaduan/model_list_pengaduan.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pengaduan_app/admin/screen/pengaduan/pegawai/pegawai_list_page.dart';

class DetailPegawaiPage extends StatelessWidget {
  final Datum data;
  const DetailPegawaiPage(this.data, {super.key});
  Future<void> approvePengaduan(
      BuildContext context, String idp, String status) async {
    try {
      http.Response res = await http.post(
          Uri.parse('${url}updatepengaduanstatus.php'),
          body: {"status": status, "id": idp});

      // Periksa apakah permintaan berhasil (status kode 200)
      if (res.statusCode == 200) {
        // Parsing respon dari JSON ke objek ModelDeleteMahasiswa
        ModelUpdateStatus data = modelUpdateStatusFromJson(res.body);

        if (data.isSuccess == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PegawaiListPage()),
              (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
          print(data.message);
        }
      } else {
        // Menampilkan pesan kesalahan jika permintaan tidak berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengubah Data')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print(e);
    }
  }

  Future<String> _downloadFile(String url) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Directory tempDir = await getTemporaryDirectory();
        final String tempPath = tempDir.path;
        final String fileName = url.split('/').last;
        final File file = File('$tempPath/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        return file.path;
      } else {
        throw Exception('Failed to download file');
      }
    } catch (e) {
      throw Exception('Error downloading file: $e');
    }
  }

  void _showPDFPopup(BuildContext context, String filePath, String tittle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tittle),
          content: Container(
            width: 300,
            height: 400,
            child: FutureBuilder<String>(
              future: _downloadFile('${url}file/${filePath}'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 400,
                      child: PDFView(
                        filePath: snapshot.data,
                      ),
                    );
                  } else {
                    return Text('Gagal memuat gambar KTP');
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => PegawaiListPage()));
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.asset("./assets/header.png"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 170),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                "Detail Laporan Pegawai",
                                style: TextStyle(
                                  color: Colors.red.shade400,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.green[100],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nama :  ${data.nama}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: data.status == 'reject'
                                        ? Colors.red
                                        : data.status == 'pending'
                                            ? Colors.amber
                                            : data.status == 'approve'
                                                ? Colors.green
                                                : Colors.transparent,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        data.status,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            height: 1.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Status: ${data.status}'),
                                Text('Nik: ${data.noKtp}'),
                                Text('Nomor HP: ${data.noHp}'),
                                SizedBox(height: 20),
                                Text(
                                  "Foto KTP",
                                  style: TextStyle(fontSize: 14, height: 1.5),
                                ),
                                FilledButton.icon(
                                  onPressed: () {
                                    _showPDFPopup(
                                        context, data.fotoKtp, "File KTP");
                                  },
                                  icon: const Icon(Icons.picture_as_pdf),
                                  label: const Text('Lihat File'),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Foto Laporan",
                                  style: TextStyle(fontSize: 14, height: 1.5),
                                ),
                                FilledButton.icon(
                                  onPressed: () {
                                    _showPDFPopup(context, data.fotoLaporan,
                                        "File Laporan");
                                  },
                                  icon: const Icon(Icons.picture_as_pdf),
                                  label: const Text('Lihat File'),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.redAccent),
                            ),
                            onPressed: () {
                              if (int.tryParse(data.id) != null) {
                                approvePengaduan(context, data.id, "reject");
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('ID tidak valid')),
                                );
                              }
                            },
                            child: Text(
                              "Recject",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.greenAccent),
                            ),
                            onPressed: () {
                              if (int.tryParse(data.id) != null) {
                                approvePengaduan(context, data.id, "approve");
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('ID tidak valid')),
                                );
                              }
                            },
                            child: Text(
                              "Approve",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

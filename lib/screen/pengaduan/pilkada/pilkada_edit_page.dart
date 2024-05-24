// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pengaduan_app/const.dart';
import 'package:pengaduan_app/model/pengaduan/model_list_pengaduan.dart';
import 'package:pengaduan_app/model/pengaduan/model_update_pengaduan.dart';
import 'package:pengaduan_app/screen/pengaduan/pegawai/pegawai_list_page.dart';
import 'package:pengaduan_app/screen/pengaduan/pengawasan/pengawasan_list_page.dart';
import 'package:pengaduan_app/screen/pengaduan/penyuluhan_hukum/penyuluhan_hukum_list_page.dart';
import 'package:pengaduan_app/screen/pengaduan/pilkada/pilkada_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PilkadaEditPage extends StatefulWidget {
  final Datum? data;
  const PilkadaEditPage(this.data, {super.key});

  @override
  State<PilkadaEditPage> createState() => _PilkadaEditPageState();
}

class _PilkadaEditPageState extends State<PilkadaEditPage> {
  File? _pdfFileKTP;
  File? _pdfFileLaporan;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _nohpController = TextEditingController();
  TextEditingController _noktpController = TextEditingController();
  TextEditingController _laporanController = TextEditingController();
  bool _isLoading = false;

  String? id, username, email, idUser;

  @override
  void initState() {
    super.initState();
    getSession();
    id = widget.data?.id;
    _namaController = TextEditingController(text: widget.data?.nama);
    _nohpController = TextEditingController(text: widget.data?.noHp);
    _noktpController = TextEditingController(text: widget.data?.noKtp);
    _laporanController = TextEditingController(text: widget.data?.laporan);

    print("id ,$id");
    print("nama , $_namaController");
    print(_pdfFileKTP);
  }

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idUser = pref.getString("id") ?? '';
      print('id $id');
      print('username $username');
    });
  }

  Future<void> _pickFile(bool isKtp) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        if (isKtp) {
          _pdfFileKTP = File(result.files.single
              .path!); // Use File constructor to create File object
        } else {
          _pdfFileLaporan = File(result.files.single
              .path!); // Use File constructor to create File object
        }
      });
    }
  }

  Future<void> registerAccount() async {
    try {
      setState(() {
        _isLoading = true;
      });

      if (_pdfFileKTP != null && _pdfFileLaporan != null) {
        var request = http.MultipartRequest(
            'POST', Uri.parse('${url}updatepengaduan.php'));
        request.fields['id'] = id!;
        request.fields['nama'] = _namaController.text;
        request.fields['no_hp'] = _nohpController.text;
        request.fields['no_ktp'] = _noktpController.text;
        request.fields['laporan'] = _laporanController.text;
        request.fields['kategori'] = "pilkada";
        request.fields['id_user'] = idUser!;
        request.files.add(await http.MultipartFile.fromPath(
          'foto_ktp',
          _pdfFileKTP!.path, // Use the path property of File
        ));

        request.files.add(await http.MultipartFile.fromPath(
          'foto_laporan',
          _pdfFileLaporan!.path, // Use the path property of File
        ));

        var res = await request.send();
        var resBody = await http.Response.fromStream(res);
        ModelUpdatePengaduan data = modelUpdatePengaduanFromJson(resBody.body);

        if (data.isSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => PilkadaListPage()),
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Please upload both files')));
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      print(e.toString());
      // Handle exception
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Text(
                            "Edit Laporan Pilkada",
                            style: TextStyle(
                              color: Colors.red.shade400,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            TextFormField(
                              controller: _namaController,
                              decoration: InputDecoration(
                                labelText: 'Nama Pelapor',
                                labelStyle: TextStyle(color: Colors.green),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan Nama Pelapor!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              controller: _nohpController,
                              decoration: InputDecoration(
                                labelText: 'No Telepon',
                                labelStyle: TextStyle(color: Colors.green),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan No Telepon Anda!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              controller: _noktpController,
                              decoration: InputDecoration(
                                labelText: 'No KTP',
                                labelStyle: TextStyle(color: Colors.green),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan No KTP Anda!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () {
                                _pickFile(true);
                              },
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.picture_as_pdf,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 8.0),
                                    Expanded(
                                      child: Text(
                                        _pdfFileKTP != null
                                            ? _pdfFileKTP!.path.split('/').last
                                            : (widget.data?.fotoKtp ??
                                                'Upload Foto KTP (PDF)'),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              maxLines: 2,
                              minLines: 1,
                              controller: _laporanController,
                              decoration: InputDecoration(
                                labelText: 'Laporan Pengaduan',
                                labelStyle:
                                    const TextStyle(color: Colors.green),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan Laporan Anda!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () {
                                _pickFile(false);
                              },
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.picture_as_pdf,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 8.0),
                                    Expanded(
                                      child: Text(
                                        _pdfFileLaporan != null
                                            ? _pdfFileLaporan!.path
                                                .split('/')
                                                .last
                                            : (widget.data?.fotoLaporan ??
                                                'Upload Foto Laporan (PDF)'),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              width: 350,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: _isLoading
                                    ? null
                                    : () async {
                                        if (_formKey.currentState?.validate() ==
                                            true) {
                                          await registerAccount();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Silahkan isi data terlebih dahulu"),
                                            ),
                                          );
                                        }
                                      },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.green,
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                ),
                                child: _isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Submit',
                                        style: TextStyle(fontSize: 20),
                                      ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                          ],
                        ),
                      ),
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

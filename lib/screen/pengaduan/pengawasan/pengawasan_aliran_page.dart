import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pengaduan_app/bottom_navigation.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:pengaduan_app/const.dart';
import 'package:async/async.dart';
import 'dart:convert'; // Needed for jsonDecode
import 'package:pengaduan_app/model/pengaduan/model_add_pengaduan.dart';
import 'package:pengaduan_app/screen/pengaduan/pengawasan/pengawasan_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengawasanAliranPage extends StatefulWidget {
  const PengawasanAliranPage({super.key});

  @override
  State<PengawasanAliranPage> createState() => _PengawasanAliranPageState();
}

class _PengawasanAliranPageState extends State<PengawasanAliranPage> {
  File? _pdfFile;
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nohpController = TextEditingController();
  final _noktpController = TextEditingController();
  final _laporanController = TextEditingController();
  bool _isLoading = false;
  File? _pdfFileKTP, _pdfFileLaporan;
  String? id, username, email;

  @override
  void initState() {
    super.initState();
    getSession();
  }

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
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
        var request =
            http.MultipartRequest('POST', Uri.parse('$url/addpengaduan.php'));
        request.fields['nama'] = _namaController.text;
        request.fields['no_hp'] = _nohpController.text;
        request.fields['no_ktp'] = _noktpController.text;
        request.fields['laporan'] = _laporanController.text;
        request.fields['kategori'] = "pengawasan";
        request.fields['id_user'] = id!;

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
        ModelAddPengaduan data = modelAddPengaduanFromJson(resBody.body);

        if (data.isSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => PengawasanListPage()),
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
      print(e);
      // Handle exception
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nohpController.dispose();
    _noktpController.dispose();
    _laporanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var placeholder = Container(
      child: ListTile(
        leading: Icon(Icons.file_copy_rounded),
        title: Text(
          "Upload PDF",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
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
                            "Pengawasan Aliran Agama \n        dan Kepercayaan",
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
                                            : 'Upload Foto KTP (PDF)',
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
                                            : 'Upload Laporan (PDF)',
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

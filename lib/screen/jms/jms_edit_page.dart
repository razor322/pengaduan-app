// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pengaduan_app/const.dart';

import 'package:pengaduan_app/model/pengaduan/model_update_pengaduan.dart';
import 'package:pengaduan_app/screen/jms/jms_list_page.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/jms/model_get_jms.dart';

class JMSEditPage extends StatefulWidget {
  final Datum? data;
  const JMSEditPage(this.data, {super.key});

  @override
  State<JMSEditPage> createState() => _JMSEditPageState();
}

class _JMSEditPageState extends State<JMSEditPage> {
  File? _pdfFileKTP;
  File? _pdfFileLaporan;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _sekolahController = TextEditingController();
  bool _isLoading = false;

  String? id, username, email, idUser;

  @override
  void initState() {
    super.initState();
    getSession();
    id = widget.data?.id;
    _namaController = TextEditingController(text: widget.data?.nama);
    _sekolahController = TextEditingController(text: widget.data?.sekolah);

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

  Future<void> registerAccount() async {
    try {
      setState(() {
        _isLoading = true;
      });

      var request =
          http.MultipartRequest('POST', Uri.parse('${url}updatejms.php'));
      request.fields['id'] = id!;
      request.fields['nama'] = _namaController.text;
      request.fields['sekolah'] = _sekolahController.text;
      request.fields['id_user'] = idUser!;

      var res = await request.send();
      var resBody = await http.Response.fromStream(res);
      ModelUpdatePengaduan data = modelUpdatePengaduanFromJson(resBody.body);

      if (data.isSuccess) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${data.message}')));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => JMSListPage()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${data.message}')));
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
                            "Edit Data JMS ",
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
                                labelText: 'Nama ',
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
                              controller: _sekolahController,
                              decoration: InputDecoration(
                                labelText: 'Sekolah',
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

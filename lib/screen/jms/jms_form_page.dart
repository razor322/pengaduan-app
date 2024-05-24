import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pengaduan_app/bottom_navigation.dart';
import 'package:pengaduan_app/const.dart';
import 'package:pengaduan_app/model/jms/model_add_jms.dart';
import 'package:pengaduan_app/utils/cek_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JMSPage extends StatefulWidget {
  const JMSPage({super.key});

  @override
  State<JMSPage> createState() => _JMSPageState();
}

class _JMSPageState extends State<JMSPage> {
  final _formKey = GlobalKey<FormState>();
  final _sekolahController = TextEditingController();
  final _namaController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

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

  Future<bool> _AddJMS() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        http.Response res = await http.post(Uri.parse('${url}addjms2.php'),
            body: {
              "nama": _namaController.text,
              "sekolah": _sekolahController.text,
              "id_user": id
            });

        ModelAddJms data = modelAddJmsFromJson(res.body);

        if (data.isSuccess == true) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNav()),
              (route) => false);
          return true;
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
          return false;
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        return false;
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
    return false;
  }

  @override
  void dispose() {
    _sekolahController.dispose();
    _namaController.dispose();
    super.dispose();
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
                    offset: Offset(0, 3), // changes position of shadow
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
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Jaksa Masuk Sekolah \n              (JMS)",
                            style: TextStyle(
                                color: Colors.red.shade400,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
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
                            SizedBox(height: 120.0),
                            TextFormField(
                              controller: _sekolahController,
                              decoration: InputDecoration(
                                labelText: 'Sekolah yang Dituju',
                                labelStyle: TextStyle(color: Colors.green),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan Nama Sekolah yang Dituju!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              controller: _namaController,
                              decoration: InputDecoration(
                                labelText: 'Nama Pemohon',
                                labelStyle: TextStyle(color: Colors.green),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan Nama Anda!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              width: 350,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => BottomNav()),
                                  // );
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    _AddJMS();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "silahkan isi data terlebih dahulu")));
                                  }
                                },

                                // _isLoading
                                //     ? null
                                //     : () async {
                                //         Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (context) =>
                                //                   BottomNav()),
                                //         );

                                //         bool success = await _AddJMS();
                                //         if (!success) {
                                //           ScaffoldMessenger.of(context).showSnackBar(
                                //               SnackBar(content: Text('Login failed')));
                                //         }
                                //       },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green), // Background color
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white), // Text color
                                ),
                                child: _isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white)
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

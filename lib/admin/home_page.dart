// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:pengaduan_app/admin/screen/jms/jms_list_page.dart';
import 'package:pengaduan_app/admin/screen/korupsi/pengaduan_korupsi_list_page.dart';
import 'package:pengaduan_app/admin/screen/pengaduan/pegawai/pegawai_list_page.dart';
import 'package:pengaduan_app/admin/screen/pengaduan/pengawasan/pengawasan_list_page.dart';
import 'package:pengaduan_app/admin/screen/pengaduan/penyuluhan_hukum/penyuluhan_hukum_list_page.dart';
import 'package:pengaduan_app/admin/screen/pengaduan/pilkada/pilkada_list_page.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pengaduan_app/const.dart';
import 'package:pengaduan_app/model/model_add_penilaian.dart';
import 'package:pengaduan_app/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<Map<String, dynamic>> data = [
    {
      "judul": "Pengaduan Pegawai",
    },
    {
      "judul": "Pengaduan Tindak Pidana Korupsi",
    },
    {
      "judul": "JMS (Jaksa Masuk Sekolah)",
    },
    {
      "judul": "Penyuluhan Hukum",
    },
    {
      "judul": "Pengawasan Aliran dan Kepercayaan",
    },
    {
      "judul": "Posko Pilkada",
    }
  ];
  final _formKey = GlobalKey<FormState>();
  final _pesanController = TextEditingController();

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
      username = pref.getString("username") ?? '';
      email = pref.getString("email") ?? '';
      print('id $id');
      print('username $username');
    });
  }

  Future<ModelAddPenilaian?> registerAccount(int ratingnilai) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        var isLoading = true;
      });

      try {
        http.Response res =
            await http.post(Uri.parse('${url}addpenilaian.php'), body: {
          "id_user": id,
          "rating": ratingnilai.toString(),
          "pesan": _pesanController.text,
        });

        final data = modelAddPenilaianFromJson(res.body);

        if (data.isSuccess == true) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
          );
        }

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data.message)));
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      } finally {
        setState(() {
          var isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.blue.shade200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text(
                'Beri Penilaian',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        controller: _pesanController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan Pesan!';
                          }
                          return null;
                        },
                        maxLines: 3,
                        decoration: InputDecoration(
                          fillColor: Colors.red,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Comment here...',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    FilledButton.tonalIcon(
                      onPressed: () {
                        final rating = 3;
                        if (_formKey.currentState?.validate() == true) {
                          registerAccount(rating);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Silahkan isi data terlebih dahulu"),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.send),
                      label: const Text('Send'),
                    ),
                  ],
                ),
              ),
            );
          },
        ).then((value) => value ?? false);
      },
      child: Scaffold(
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
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "PUSAT INFORMASI ",
                                  style: TextStyle(
                                    color: Colors.red.shade400,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  " KEJAKSAAN TINGGI SUMATERA BARAT",
                                  style: TextStyle(
                                    color: Colors.red.shade400,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ImageSlideshow(
                              width: double.infinity,
                              height: 200,
                              initialPage: 0,
                              indicatorColor: Colors.blue,
                              indicatorBackgroundColor: Colors.grey,
                              children: [
                                Image.asset(
                                  './assets/image1.png',
                                  fit: BoxFit.cover,
                                ),
                                Image.asset(
                                  './assets/image2.png',
                                  fit: BoxFit.cover,
                                ),
                                Image.asset(
                                  './assets/image1.png',
                                  fit: BoxFit.cover,
                                ),
                              ],
                              onPageChanged: (value) {
                                print('Page changed: $value');
                              },
                              autoPlayInterval: 3000,
                              isLoop: true,
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                " LAPOR",
                                style: TextStyle(
                                  color: Colors.red.shade400,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.report_gmailerrorred_sharp,
                          color: Colors.red,
                        ),
                        title: Text(data[index]['judul']),
                        onTap: () {
                          switch (index) {
                            case 0:
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PegawaiListPage()),
                                  (route) => false);
                              break;
                            case 1:
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PengaduanKorupsiListPage()),
                                  (route) => false);
                              break;
                            case 2:
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JMSListPage()),
                                  (route) => false);

                              break;
                            case 3:
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PenyuluhanHukumListPage()),
                                  (route) => false);
                              break;
                            case 4:
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PengawasanListPage()),
                                  (route) => false);
                              break;
                            case 5:
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PilkadaListPage()),
                                  (route) => false);
                              break;
                            default:
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

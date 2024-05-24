// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:pengaduan_app/screen/jms/jms_list_page.dart';
import 'package:pengaduan_app/screen/korupsi/pengaduan_korupsi_list_page.dart';
import 'package:pengaduan_app/screen/korupsi/pengaduan_korupsi_page.dart';
import 'package:pengaduan_app/screen/pengaduan/pegawai/pegawai_list_page.dart';
import 'package:pengaduan_app/screen/pengaduan/pengawasan/pengawasan_list_page.dart';
import 'package:pengaduan_app/screen/pengaduan/penyuluhan_hukum/penyuluhan_hukum_list_page.dart';
import 'package:pengaduan_app/screen/pengaduan/pilkada/pilkada_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Icon(
                        index < 4 ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 35,
                      );
                    }),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
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
                ],
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
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => JMSPage()),
                              //     (route) => false);
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

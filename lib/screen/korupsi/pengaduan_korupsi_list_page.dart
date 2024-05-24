import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pengaduan_app/bottom_navigation.dart';
import 'package:pengaduan_app/const.dart';
import 'package:pengaduan_app/model/korupsi/model_list_korupsi.dart';
import 'package:pengaduan_app/model/pengaduan/model_hapus_pengaduan.dart';
import 'package:pengaduan_app/screen/korupsi/pengaduan_korupsi_detail_page.dart';
import 'package:pengaduan_app/screen/korupsi/pengaduan_korupsi_edit_page.dart';
import 'package:pengaduan_app/screen/korupsi/pengaduan_korupsi_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PengaduanKorupsiListPage extends StatefulWidget {
  const PengaduanKorupsiListPage({Key? key}) : super(key: key);

  @override
  State<PengaduanKorupsiListPage> createState() =>
      _PengaduanKorupsiListPageState();
}

class _PengaduanKorupsiListPageState extends State<PengaduanKorupsiListPage> {
  bool isLoading = false;
  late List<Datum> _searchResult = [];
  String? id, username, email;

  @override
  void initState() {
    super.initState();
    getSession().then((_) {
      getJMS();
    });
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

  Future<void> getJMS() async {
    if (id == null || id!.isEmpty) {
      print('User ID is null or empty.');
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        Uri.parse('${url}listkorupsi.php'),
        body: {"id_user": id},
      );
      if (response.statusCode == 200) {
        final data = modelListKorupsiFromJson(response.body).data ?? [];
        setState(() {
          _searchResult = data;
          isLoading = false;
        });
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  Future<void> deletePengaduan(int id) async {
    var idPengaduan = id;
    try {
      setState(() {
        isLoading = false;
      });
      http.Response res = await http.post(Uri.parse('${url}hapuskorupsi.php'),
          body: {"id": idPengaduan.toString()});

      // Periksa apakah permintaan berhasil (status kode 200)
      if (res.statusCode == 200) {
        // Parsing respon dari JSON ke objek ModelDeleteMahasiswa
        ModelHapusPengaduan data = modelHapusPengaduanFromJson(res.body);

        if (data.status == "success") {
          setState(() {
            _searchResult.removeWhere((sejarah) => sejarah.id == id.toString());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}')),
            );
          });

          setState(() {
            getJMS();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
          print(data.message);
        }
      } else {
        // Menampilkan pesan kesalahan jika permintaan tidak berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus Data')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BottomNav()));
          },
          icon: Icon(Icons.home),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.blue.shade300,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PengaduanKorupsipage()));
        },
        tooltip: "tambah laporan",
        child: Icon(
          Icons.add,
          size: 25,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    ListTile(
                      leading: Icon(Icons.home),
                    ),
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
                                    "Laporan Pengaduan korupsi",
                                    style: TextStyle(
                                      color: Colors.red.shade400,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: _searchResult.length,
                              itemBuilder: (context, index) {
                                Datum data = _searchResult[index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PengaduanKorupsiDetailPage(
                                                    data)),
                                        (route) => false);
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Colors.green[100],
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.nama,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    tooltip: "hapus data",
                                                    onPressed: () {
                                                      String idToDelete =
                                                          _searchResult[index]
                                                              .id;

                                                      if (int.tryParse(
                                                              idToDelete) !=
                                                          null) {
                                                        deletePengaduan(
                                                            int.parse(
                                                                idToDelete));
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  'ID tidak valid')),
                                                        );
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    tooltip: "edit data",
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PengaduanKorupsiEditPage(
                                                                      data)));
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: Colors
                                                          .yellow.shade800,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.laporan,
                                                style: TextStyle(
                                                    fontSize: 14, height: 1.5),
                                              ),
                                              SizedBox(height: 20),
                                              Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Colors.amber),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    data.status,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        height: 1.5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

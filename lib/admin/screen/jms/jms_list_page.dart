import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pengaduan_app/admin/bottom_navigation_admin.dart';
import 'package:pengaduan_app/admin/screen/jms/detail_jms_page.dart';
import 'package:pengaduan_app/bottom_navigation.dart';
import 'package:pengaduan_app/const.dart';
import 'package:pengaduan_app/model/jms/model_get_jms.dart';
import 'package:pengaduan_app/model/pengaduan/model_hapus_pengaduan.dart';
import 'package:pengaduan_app/screen/jms/jms_edit_page.dart';
import 'package:pengaduan_app/screen/jms/jms_form_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JMSListPage extends StatefulWidget {
  const JMSListPage({Key? key}) : super(key: key);

  @override
  State<JMSListPage> createState() => _JMSListPageState();
}

class _JMSListPageState extends State<JMSListPage> {
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
        Uri.parse('${url}listjmsadmin.php'),
      );
      if (response.statusCode == 200) {
        final data = modelAddJmsFromJson(response.body).data ?? [];

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
        content: Text("Data Laporan Pengaduan kosong"),
      ));
    }
  }

  Future<void> deletePengaduan(int id) async {
    var idPengaduan = id;
    try {
      setState(() {
        isLoading = false;
      });
      http.Response res = await http.post(Uri.parse('${url}hapusjms.php'),
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
        SnackBar(content: Text('Data Laporan Pengaduan kosong')),
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomNavAdmin()));
              },
              icon: Icon(Icons.home))),
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
                                    "Jaksa Masuk Sekolah ",
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
                                                DetailJMSPage(data)),
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
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            data.sekolah,
                                            style: TextStyle(
                                                fontSize: 14, height: 1.5),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
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

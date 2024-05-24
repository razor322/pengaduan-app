import 'package:flutter/material.dart';
import 'package:pengaduan_app/screen/login.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilAdminPage extends StatefulWidget {
  const ProfilAdminPage({super.key});

  @override
  State<ProfilAdminPage> createState() => _ProfilAdminPageState();
}

class _ProfilAdminPageState extends State<ProfilAdminPage> {
  String? id, username, email;

  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
    updateProfile();
  }

  void updateProfile() {
    getSession(); // Panggil kembali fungsi getSession untuk memperbarui data
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      username = pref.getString("username") ?? '';
      email = pref.getString("email") ?? '';
      print('id $id');
      print('username $username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Stack for profile picture and edit icon
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
                            "Admin Profile",
                            style: TextStyle(
                              color: Colors.red.shade400,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40.0),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 80.0,
                          //    backgroundImage: AssetImage('assets/images/profile.png'),
                        ),
                        // Button to change profile picture
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.camera_alt, color: Colors.black),
                            onPressed: () {
                              // Logic to change profile picture
                              // This might include showing a dialog or navigating to a new screen
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.0),

                    // User information
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "$username",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$email",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Space between user information and buttons
                    SizedBox(height: 100.0),

                    // Edit profile button
                    // ElevatedButton(
                    //   onPressed: () {
                    //     // Navigator.push(
                    //     //   context,
                    //     //   MaterialPageRoute(builder: (context) => EditProfile()),
                    //     // );
                    //   },
                    //   style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.all<Color>(
                    //         Colors.white), // Background color green
                    //     foregroundColor: MaterialStateProperty.all<Color>(
                    //         Colors.green), // Text color white
                    //   ),
                    //   child: Text('Edit Profile'),
                    // ),

                    // Space between Edit Profile and Log out buttons
                    Container(
                      width: 350, // Lebar tombol
                      height: 60, // Tinggi tombol

                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           LoginScreen()), // Log out userr
                          // ); // Add your logout logic here
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent), // Background color
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // Text color
                        ),
                        child: Text(
                          'About Us',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      width: 350, // Lebar tombol
                      height: 60, // Tinggi tombol

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginScreen()), // Log out userr
                          ); // Add your logout logic here
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent), // Background color
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // Text color
                        ),
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Space between profile picture and user information
          ],
        ),
      ),
    );
  }
}

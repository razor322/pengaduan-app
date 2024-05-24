// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

import 'package:pengaduan_app/admin/home_page.dart';

import 'profil_admin_page.dart';

class BottomNavAdmin extends StatefulWidget {
  @override
  _BottomNavAdminState createState() => _BottomNavAdminState();
}

class _BottomNavAdminState extends State<BottomNavAdmin> {
  int _selectedIndex = 0;

  // Daftar halaman sebagai widget
  static List<Widget> _widgetOptions = <Widget>[
    AdminHomePage(),
    ProfilAdminPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

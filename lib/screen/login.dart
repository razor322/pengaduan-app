// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pengaduan_app/admin/bottom_navigation_admin.dart';
import 'package:pengaduan_app/bottom_navigation.dart';
import 'package:pengaduan_app/const.dart';
import 'package:pengaduan_app/model/model_login.dart';
import 'package:pengaduan_app/screen/home_page.dart';
import 'package:pengaduan_app/screen/register.dart';
import 'package:pengaduan_app/utils/cek_session.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false; // Menambahkan flag untuk status loading

  Future<bool> _loginProcess() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        http.Response res = await http.post(Uri.parse('${url}login.php'),
            body: {
              "email": _emailController.text,
              "password": _passwordController.text
            });

        ModelLogin data = modelLoginFromJson(res.body);

        if (data.value == 1) {
          session.saveSession(data.value ?? 0, data.id ?? "",
              data.username ?? "", data.email ?? "");

          if (data.isAdmin == "1") {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('admin')));

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomNavAdmin()),
                (route) => false);
            return true;
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('user')));

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomNav()),
                (route) => false);
            return true;
          }
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
    _emailController.dispose();
    _passwordController.dispose();
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
                            "LOGIN",
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
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.green),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.green,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.green),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.green,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
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
                                    _loginProcess();
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

                                //         bool success = await _loginProcess();
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
                                    : Text('Log In'),
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
      bottomNavigationBar: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
          child: RichText(
            text: TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(color: Colors.black),
              children: const <TextSpan>[
                TextSpan(
                    text: 'Register',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ],
            ),
          )),
    );
  }
}

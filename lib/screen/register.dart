import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pengaduan_app/const.dart';
import 'package:pengaduan_app/model/model_register.dart';
import 'package:pengaduan_app/screen/login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _notelpController = TextEditingController();
  final _noktpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _alamatController = TextEditingController();
  bool _obscurePassword = true; // State untuk mengontrol visibilitas password
  bool isLoading = false;

  Future<ModelRegister?> registerAccount() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        http.Response res =
            await http.post(Uri.parse('${url}register.php'), body: {
          "username": _namaController.text,
          "password": _passwordController.text,
          "email": _emailController.text,
          "no_tlp": _notelpController.text,
          "alamat": _namaController.text,
          "nik": _noktpController.text,
        });
        print(_notelpController.text);
        print(_namaController.text);
        print(_emailController.text);
        print(_noktpController.text);
        print(_passwordController.text);
        final data = modelRegisterFromJson(res.body);

        if (data.value == 1) {
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
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _notelpController.dispose();
    _noktpController.dispose();
    _alamatController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
            SingleChildScrollView(
              child: Padding(
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
                              "REGISTER",
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              TextFormField(
                                controller: _namaController,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.2),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan Username Anda';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.2),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan email Anda';
                                  } else if (!value.contains('@')) {
                                    return 'Masukkan email yang valid';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                controller: _notelpController,
                                decoration: InputDecoration(
                                  labelText: 'No Telepon',
                                  labelStyle: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.2),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan No Telepon anda Anda';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                controller: _alamatController,
                                decoration: InputDecoration(
                                  labelText: 'Alamat',
                                  labelStyle: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.2),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan Alamat anda Anda';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                controller: _noktpController,
                                decoration: InputDecoration(
                                  labelText: 'No KTP',
                                  labelStyle: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.2),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan No KTP Anda';
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
                                  labelStyle: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.2),
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
                                    return 'Masukkan password Anda';
                                  } else if (value.length < 3) {
                                    return 'Password harus memiliki minimal 6 karakter';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                width: 360,
                                height: 60,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  onPressed: () {
                                    //    registerAccount();

                                    if (_formKey.currentState?.validate() ==
                                        true) {
                                      registerAccount();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "silahkan isi data terlebih dahulu")));
                                    }
                                  },
                                  color: Colors.green.shade300,
                                  disabledColor: Colors.grey,
                                  textColor: Colors.white,
                                  height: 45,
                                  child: isLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.white)
                                      : Text('Register'),
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: RichText(
            text: TextSpan(
              text: 'Have an Account? ',
              style: TextStyle(color: Colors.black),
              children: const <TextSpan>[
                TextSpan(
                    text: 'Login',
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

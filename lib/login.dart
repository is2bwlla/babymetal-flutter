import 'package:babymetal/ingressos.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

TextEditingController _user = TextEditingController();
TextEditingController _pass = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String registedUser = 'isabella';
  String registedPassword = 'igorbedon';
  String verificated = '';

  bool logar() {
    if (_user.text == registedUser && _pass.text == registedPassword) {
      print('Correct credentials.');
      return true;
    } else {
      print("Iconcorrect credentials.");
      setState(() {
        verificated = 'Incorrect credentials.';
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/wallpaper.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset("assets/images/logo.png", width: double.infinity),
                  SizedBox(height: 20),
                  Text(
                    "NO BRASIL",
                    style: TextStyle(
                      fontFamily: "poppins",
                      fontSize: 50,
                      color: Color(0xFFE3DFD3),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 10.0,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "USUARIO",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w900),
                      border: OutlineInputBorder(),
                    ),
                    controller: _user,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "SENHA",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w900),
                      border: OutlineInputBorder(),
                    ),
                    controller: _pass,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (logar()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IngressoPage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE3DFD3),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text("LOGIN",
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 25,
                      color: Color(0xFF310A03),
                      fontWeight: FontWeight.w900
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

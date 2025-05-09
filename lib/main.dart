import 'package:babymetal/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'poppins'),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/wallpaper.png"),
            fit: BoxFit.cover, 
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE3DFD3),
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

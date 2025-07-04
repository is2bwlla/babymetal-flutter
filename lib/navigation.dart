import 'package:babymetal/cadastro_cartao.dart';
import 'package:babymetal/details.dart';
import 'package:babymetal/historico.dart';
import 'package:babymetal/ingressos.dart';
import 'package:babymetal/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:babymetal/api.dart';
import 'package:babymetal/mapa.dart';

class NavApp extends StatefulWidget {
  const NavApp({super.key});

  @override
  State<NavApp> createState() => _NavAppState();
}

class _NavAppState extends State<NavApp> {
  int selectIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold
  );

  static List<Widget> _widgetOptions = <Widget> [    
    IngressoPage(),
    CartaoHistoryScreen(),
    ConselhosPage(),
    Mapa()
  ];

  void showItemTrap(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(selectIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history),
            label: "History",
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(icon: Icon(Icons.message),
            label: "Conselhos",
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map),
            label: "Map",
            backgroundColor: Colors.black
          )
        ],
        currentIndex: selectIndex,
        selectedItemColor: Colors.red,
        onTap: showItemTrap,
      ),
    );
  }
}
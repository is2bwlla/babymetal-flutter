import 'dart:convert';
import 'package:babymetal/login.dart'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 

class ConselhosPage extends StatefulWidget {
  const ConselhosPage({super.key});

  @override
  State<ConselhosPage> createState() => _ConselhosPageState();
}

class _ConselhosPageState extends State<ConselhosPage> {
  String? conselhos;

  @override
  void initState() {
    super.initState();
    getConselhos(); 
  }

  void getConselhos() async {
    try {
      final response = await http.get(Uri.parse("https://api.adviceslip.com/advice"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          conselhos = data['slip']['advice']; 
        });
      } else {
        setState(() {
          conselhos = "Erro ao carregar conselhos. Código: ${response.statusCode}"; 
        });
      }
    } catch (e) {
      setState(() {
        conselhos = "Não foi possível conectar. Verifique sua internet."; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Conselhos para Você", 
          style: TextStyle(color: Colors.white, fontFamily: "poppins"),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/wallpaper.png"), 
            fit: BoxFit.cover, 
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0), 
            child: conselhos == null
                ? const CircularProgressIndicator(color: Color(0xFFE3DFD3)) 
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Text(
                        conselhos!,
                        textAlign: TextAlign.center, 
                        style: const TextStyle(
                          color: Color(0xFFE3DFD3), 
                          fontFamily: "poppins", 
                          fontSize: 22, 
                          fontWeight: FontWeight.bold, 
                        ),
                      ),
                      const SizedBox(height: 30), 
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            conselhos = null; 
                          });
                          getConselhos(); 
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE3DFD3), 
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), 
                          ),
                        ),
                        child: const Text(
                          "Novo Conselho",
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 18,
                            color: Color(0xFF310A03),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
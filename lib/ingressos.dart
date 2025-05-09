import 'package:babymetal/details.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Ingresso {
  final String local;
  final String estado;
  final String data;
  final String horario;
  final String description;
  final String image;
  final String status;

  Ingresso({
    required this.local,
    required this.estado,
    required this.data,
    required this.horario,
    required this.description,
    required this.image,
    required this.status,
  });
}

class IngressoPage extends StatelessWidget {
  IngressoPage({super.key});

  final List<Ingresso> IngressoList = [
    Ingresso(
      local: "Allianz Parque -",
      estado: "SP",
      data: "08/08/2025 -",
      horario: "18:00h",
      description: "Arena VIP",
      image: "assets/images/ingressobabymetal.png",
      status: "ESGOTADO"
    ),
    Ingresso(
      local: "Allianz Parque -",
      estado: "SP",
      data: "10/08/2025",
      horario: "15:00h",
      description: "Arena VIP",
      image: "assets/images/ingressobabymetal.png",
      status: "DISPONÍVEL"
    ),
    Ingresso(
      local: "Allianz Parque -",
      estado: "SP",
      data: "28/08/2025",
      horario: "18:00h",
      description: "Arena VIP",
      image: "assets/images/ingressobabymetal.png",
      status: "ESGOTADO"
    ),
    Ingresso(
      local: "Allianz Parque -",
      estado: "SP",
      data: "31/08/2025",
      horario: "15:00h",
      description: "Arena VIP",
      image: "assets/images/ingressobabymetal.png",
      status: "DISPONÍVEL"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingressos", style: TextStyle(color: Colors.white)),
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
        child: ListView.builder(
          itemCount: IngressoList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsIngressoPage(
                      ingresso: IngressoList[index],
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2), 
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        IngressoList[index].image,
                        width: MediaQuery.of(context).size.width * 0.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 1,
                      height: double.infinity,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${IngressoList[index].local} ${IngressoList[index].estado}",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "${IngressoList[index].data} ${IngressoList[index].horario}",
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          SizedBox(height: 6),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: IngressoList[index].status == "DISPONÍVEL" ? Colors.green: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              IngressoList[index].status,
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

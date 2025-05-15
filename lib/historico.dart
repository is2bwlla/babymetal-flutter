import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartaoHistoryScreen extends StatefulWidget {
  const CartaoHistoryScreen({super.key});

  @override
  State<CartaoHistoryScreen> createState() => _CartaoHistoryScreenState();
}

class _CartaoHistoryScreenState extends State<CartaoHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // fundo escuro
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('ingresso').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Não tem dados disponíveis.', style: TextStyle(color: Colors.white)));
          }

          var dataList = snapshot.data!.docs;

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                color: Colors.white,
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back, color: Colors.black),
                    SizedBox(width: 10),
                    Text(
                      'HISTÓRICO CARTÕES',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF3B0000), Color(0xFF1A0000)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      var data = dataList[index].data() as Map<String, dynamic>;

                      String nome = (data['nome'] ?? '').toString();
                      String numero = (data['numero'] ?? '').toString();

                      // Pega só os últimos 4 dígitos do número (string)
                      if (numero.length > 4) {
                        numero = numero.substring(numero.length - 4);
                      } else {
                        numero = numero.padLeft(4, '0');
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              nome.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  numero,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.white),
                                  onPressed: () {
                                    // Lógica para deletar o item
                                    FirebaseFirestore.instance
                                        .collection('ingresso')
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete();
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class CartaoHistoryScreen extends StatefulWidget {
//   const CartaoHistoryScreen({super.key});

//   @override
//   State<CartaoHistoryScreen> createState() => _CartaoHistoryScreenState();
// }

// class _CartaoHistoryScreenState extends State<CartaoHistoryScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black, 
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('ingresso').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('Não tem dados disponíveis.', style: TextStyle(color: Colors.white)));
//           }

//           var dataList = snapshot.data!.docs;

//           return Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//                 color: Colors.white,
//                 child: Row(
//                   children: const [
//                     Icon(Icons.arrow_back, color: Colors.black),
//                     SizedBox(width: 10),
//                     Text(
//                       'HISTÓRICO CARTÕES',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         letterSpacing: 1.2,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Color(0xFF3B0000), Color(0xFF1A0000)],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                   child: ListView.builder(
//                     padding: const EdgeInsets.all(20),
//                     itemCount: dataList.length,
//                     itemBuilder: (context, index) {
//                       var data = dataList[index].data() as Map<String, dynamic>;

//                       String nome = (data['nome'] ?? '').toString();
//                       String numero = (data['numero'] ?? '').toString();

//                       if (numero.length > 4) {
//                         numero = numero.substring(numero.length - 4);
//                       } else {
//                         numero = numero.padLeft(4, '0');
//                       }

//                       return Container(
//                         margin: const EdgeInsets.only(bottom: 20),
//                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                         decoration: BoxDecoration(
//                           color: Colors.transparent,
//                           border: Border.all(color: Colors.white),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               nome.toUpperCase(),
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   numero,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 IconButton(
//                                   icon: const Icon(Icons.delete_outline, color: Colors.white),
//                                   onPressed: () {
//                                     FirebaseFirestore.instance
//                                         .collection('ingresso')
//                                         .doc(snapshot.data!.docs[index].id)
//                                         .delete();
//                                   },
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:babymetal/cadastro_cartao.dart'; 

class CartaoHistoryScreen extends StatefulWidget {
  const CartaoHistoryScreen({super.key});

  @override
  State<CartaoHistoryScreen> createState() => _CartaoHistoryScreenState();
}

class _CartaoHistoryScreenState extends State<CartaoHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('ingresso').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Não tem dados disponíveis.', style: TextStyle(color: Colors.white, fontFamily: "poppins")));
          }

          var dataList = snapshot.data!.docs;

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                color: Colors.black, 
                child: SafeArea(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context); 
                        },
                      ),
                      const SizedBox(width: 10),
                      // Título
                      const Text(
                        'HISTÓRICO CARTÕES',
                        style: TextStyle(
                          color: Colors.white, 
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 1.2,
                          fontFamily: "poppins", 
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/wallpaper.png"), 
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      var doc = dataList[index]; 
                      var data = doc.data() as Map<String, dynamic>;
                      String documentId = doc.id; 

                      String nome = (data['nome'] ?? '').toString();
                      String numero = (data['numero'] ?? '').toString();

                      if (numero.length > 4) {
                        numero = "**** **** **** ${numero.substring(numero.length - 4)}"; 
                      } else {
                        numero = "********${numero.padLeft(4, '0')}"; 
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: const Color(0xFFE3DFD3)), 
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nome.toUpperCase(),
                                  style: const TextStyle(
                                    color: Color(0xFFE3DFD3), 
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "poppins",
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  numero,
                                  style: const TextStyle(
                                    color: Color(0xFFE3DFD3), 
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "poppins",
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Color(0xFFE3DFD3)), 
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PostCartao(
                                          cartaoData: data, 
                                          documentId: documentId, 
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 10),
                                // Botão de DELETAR
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent), 
                                  onPressed: () async {
                                    bool? confirmDelete = await showDialog<bool>(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return AlertDialog(
                                          backgroundColor: Colors.black, 
                                          title: const Text('Confirmar Exclusão', style: TextStyle(color: Colors.white, fontFamily: "poppins")),
                                          content: const Text('Tem certeza que deseja excluir este cartão?', style: TextStyle(color: Colors.white, fontFamily: "poppins")),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.of(dialogContext).pop(false),
                                              child: const Text('Cancelar', style: TextStyle(color: Color(0xFFE3DFD3), fontFamily: "poppins")),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.of(dialogContext).pop(true),
                                              child: const Text('Excluir', style: TextStyle(color: Colors.redAccent, fontFamily: "poppins")),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    if (confirmDelete == true) {
                                      try {
                                        await FirebaseFirestore.instance
                                            .collection('ingresso')
                                            .doc(documentId) 
                                            .delete();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Cartão excluído com sucesso!')),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Erro ao excluir cartão: $e')),
                                        );
                                      }
                                    }
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

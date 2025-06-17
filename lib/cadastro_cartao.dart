// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PostCartao extends StatefulWidget {
//   const PostCartao({super.key});

//   @override
//   State<PostCartao> createState() => _PostCartaoState();
// }

// class _PostCartaoState extends State<PostCartao> {
//   final TextEditingController nomeController = TextEditingController();
//   final TextEditingController numeroController = TextEditingController();
//   final TextEditingController mesController = TextEditingController();
//   final TextEditingController anoController = TextEditingController();
//   final TextEditingController cvvController = TextEditingController();

//   Future<void> postCartao() async {
//     final String nome = nomeController.text.trim();
//     final String numero = numeroController.text.trim();
//     final String mesStr = mesController.text.trim();
//     final String anoStr = anoController.text.trim();
//     final String cvvStr = cvvController.text.trim();

//     if (nome.isEmpty || numero.isEmpty || mesStr.isEmpty || anoStr.isEmpty || cvvStr.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Por favor, preencha todos os campos!")),
//       );
//       return;
//     }

//     final int mes = int.tryParse(mesStr) ?? 0;
//     final int ano = int.tryParse(anoStr) ?? 0;
//     final int cvv = int.tryParse(cvvStr) ?? 0;

//     try {
//       await FirebaseFirestore.instance.collection('ingresso').add({
//         'nome': nome,
//         'numero': numero,
//         'mes': mes,
//         'ano': ano,
//         'cvv': cvv,
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Seus dados foram enviados com sucesso!")),
//       );

//       nomeController.clear();
//       numeroController.clear();
//       mesController.clear();
//       anoController.clear();
//       cvvController.clear();
//     } catch (e) {
//       print("Erro ao enviar os dados: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Erro ao enviar os dados: $e")),
//       );
//     }
//   }

//   Widget buildTextField(TextEditingController controller, String hint) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//         keyboardType: TextInputType.numberWithOptions(),
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.white),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.white),
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Informações do Cartão',
//           style: TextStyle(color: Colors.white, fontFamily: "poppins"),
//         ),
//         iconTheme: IconThemeData(color: Colors.white),
//         backgroundColor: Colors.black,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/wallpaper.png"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 buildTextField(nomeController, 'NOME NO CARTÃO'),
//                 buildTextField(numeroController, 'NÚMERO NO CARTÃO'),
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 16, bottom: 8),
//                     child: Text(
//                       'DATA DE VENCIMENTO:',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(child: buildTextField(mesController, 'MÊS')),
//                     const SizedBox(width: 10),
//                     Expanded(child: buildTextField(anoController, 'ANO')),
//                   ],
//                 ),
//                 buildTextField(cvvController, 'CVV'),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: postCartao,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'CADASTRAR',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostCartao extends StatefulWidget {
  // 1. Adicione os parâmetros nomeados ao construtor
  final Map<String, dynamic>? cartaoData; // Para os dados do cartão
  final String? documentId; // Para o ID do documento no Firestore

  const PostCartao({super.key, this.cartaoData, this.documentId});

  @override
  State<PostCartao> createState() => _PostCartaoState();
}

class _PostCartaoState extends State<PostCartao> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController mesController = TextEditingController();
  final TextEditingController anoController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  // Flag para identificar se estamos no modo de edição
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    // 2. Verifique se há dados de cartão passados (modo de edição)
    if (widget.cartaoData != null && widget.documentId != null) {
      isEditing = true;
      // Preencha os controladores com os dados existentes do cartão
      nomeController.text = widget.cartaoData!['nome'] ?? '';
      // Para o número, talvez você queira mostrar ele completo para edição
      numeroController.text = widget.cartaoData!['numero'] ?? '';
      mesController.text = (widget.cartaoData!['mes'] ?? '').toString();
      anoController.text = (widget.cartaoData!['ano'] ?? '').toString();
      cvvController.text = (widget.cartaoData!['cvv'] ?? '').toString();
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    numeroController.dispose();
    mesController.dispose();
    anoController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  Future<void> _saveCartao() async {
    final String nome = nomeController.text.trim();
    final String numero = numeroController.text.trim();
    final String mesStr = mesController.text.trim();
    final String anoStr = anoController.text.trim();
    final String cvvStr = cvvController.text.trim();

    if (nome.isEmpty || numero.isEmpty || mesStr.isEmpty || anoStr.isEmpty || cvvStr.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, preencha todos os campos!")),
      );
      return;
    }

    final int mes = int.tryParse(mesStr) ?? 0;
    final int ano = int.tryParse(anoStr) ?? 0;
    final int cvv = int.tryParse(cvvStr) ?? 0;

    // Dados a serem salvos/atualizados
    Map<String, dynamic> cardData = {
      'nome': nome,
      'numero': numero,
      'mes': mes,
      'ano': ano,
      'cvv': cvv,
    };

    try {
      if (isEditing && widget.documentId != null) {
        // Modo de edição: atualiza o documento existente
        await FirebaseFirestore.instance.collection('ingresso').doc(widget.documentId).update(cardData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cartão atualizado com sucesso!")),
        );
      } else {
        // Modo de criação: adiciona um novo documento
        await FirebaseFirestore.instance.collection('ingresso').add(cardData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Seus dados foram enviados com sucesso!")),
        );
      }

      // Limpa os campos após salvar, se for um novo cartão
      // Se estiver editando, não limpamos para que o usuário possa ver os dados atualizados
      if (!isEditing) {
        nomeController.clear();
        numeroController.clear();
        mesController.clear();
        anoController.clear();
        cvvController.clear();
      }

      // Após salvar/atualizar, volte para a tela anterior (histórico)
      Navigator.pop(context);
    } catch (e) {
      print("Erro ao salvar/atualizar os dados: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao salvar/atualizar os dados: $e")),
      );
    }
  }

  // Refatorado para usar keyboardType
  Widget buildTextField(TextEditingController controller, String hint, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: "poppins",
        ),
        keyboardType: keyboardType, // Define o tipo de teclado
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontFamily: "poppins",
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Título dinâmico: "Editar Cartão" ou "Informações do Cartão"
        title: Text(
          isEditing ? 'Editar Cartão' : 'Informações do Cartão',
          style: const TextStyle(color: Colors.white, fontFamily: "poppins"),
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Para o nome, o teclado deve ser de texto, não numérico
                buildTextField(nomeController, 'NOME NO CARTÃO', keyboardType: TextInputType.text),
                buildTextField(numeroController, 'NÚMERO NO CARTÃO', keyboardType: TextInputType.number),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'DATA DE VENCIMENTO:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontFamily: "poppins",
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    // Mês e Ano são numéricos
                    Expanded(child: buildTextField(mesController, 'MÊS', keyboardType: TextInputType.number)),
                    const SizedBox(width: 10),
                    Expanded(child: buildTextField(anoController, 'ANO', keyboardType: TextInputType.number)),
                  ],
                ),
                // CVV é numérico
                buildTextField(cvvController, 'CVV', keyboardType: TextInputType.number),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveCartao, // Chama a função de salvar/atualizar
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE3DFD3), // Cor do botão do login
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    // Texto do botão dinâmico: "ATUALIZAR" ou "CADASTRAR"
                    isEditing ? 'ATUALIZAR' : 'CADASTRAR',
                    style: const TextStyle(
                      color: Color(0xFF310A03), // Cor do texto do botão do login
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 1.2,
                      fontFamily: "poppins",
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
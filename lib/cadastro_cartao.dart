import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostCartao extends StatefulWidget {
  const PostCartao({super.key});

  @override
  State<PostCartao> createState() => _PostCartaoState();
}

class _PostCartaoState extends State<PostCartao> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController mesController = TextEditingController();
  final TextEditingController anoController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  Future<void> postCartao() async {
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

    try {
      await FirebaseFirestore.instance.collection('ingresso').add({
        'nome': nome,
        'numero': numero,
        'mes': mes,
        'ano': ano,
        'cvv': cvv,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Seus dados foram enviados com sucesso!")),
      );

      nomeController.clear();
      numeroController.clear();
      mesController.clear();
      anoController.clear();
      cvvController.clear();
    } catch (e) {
      print("Erro ao enviar os dados: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao enviar os dados: $e")),
      );
    }
  }

  Widget buildTextField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
        title: Text(
          'Informações do Cartão',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
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
                buildTextField(nomeController, 'NOME NO CARTÃO'),
                buildTextField(numeroController, 'NÚMERO NO CARTÃO'),
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
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: buildTextField(mesController, 'MÊS')),
                    const SizedBox(width: 10),
                    Expanded(child: buildTextField(anoController, 'ANO')),
                  ],
                ),
                buildTextField(cvvController, 'CVV'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: postCartao,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'CADASTRAR',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 1.2,
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

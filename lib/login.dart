import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'package:babymetal/navigation.dart'; 
import 'package:babymetal/auth.dart'; 
import 'firebase_options.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService(); 

  String _errorMessage = ''; 

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }


  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      print("Erro ao inicializar Firebase: $e");
      setState(() {
        _errorMessage = "Erro ao carregar o aplicativo. Tente novamente.";
      });
    }
  }

  Future<void> _performLogin() async {
    setState(() {
      _errorMessage = ''; 
    });

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "Por favor, preencha todos os campos.";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage)),
      );
      return;
    }

    final String? message = await _authService.login(email: email, password: password);

    if (message == "Login bem-sucedido!") {
      print('Login bem-sucedido!');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavApp())); 
    } else {
      print("Erro de login: $message");
      setState(() {
        _errorMessage = message ?? "Erro desconhecido ao logar.";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage)),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login", style: TextStyle(color: Colors.white, fontFamily: "poppins")),
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset("assets/images/logo.png", width: double.infinity),
                  const SizedBox(height: 20),
                  const Text(
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
                    controller: _emailController, 
                    decoration: const InputDecoration(
                      hintText: "EMAIL", 
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w900,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress, 
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController, 
                    decoration: const InputDecoration(
                      hintText: "SENHA", 
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w900,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                  ),
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
              ElevatedButton(
                onPressed: _performLogin, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE3DFD3),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 25,
                    color: Color(0xFF310A03),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              TextButton(
                onPressed: () async {
                  final String email = _emailController.text.trim();
                  final String password = _passwordController.text.trim();

                  if (email.isEmpty || password.isEmpty) {
                    setState(() {
                      _errorMessage = "Para registrar, preencha email e senha.";
                    });
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(_errorMessage)),
                    );
                    return;
                  }

                  final String? message = await _authService.registration(email: email, password: password);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message ?? "Erro desconhecido ao registrar.")),
                  );
                  if (message == "Usuário registrado com sucesso!") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const NavApp()),
                    );
                  }
                },
                child: const Text(
                  "Não tem uma conta? Registre-se aqui.",
                  style: TextStyle(color: Color(0xFFE3DFD3)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

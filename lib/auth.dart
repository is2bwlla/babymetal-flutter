import 'package:firebase_auth/firebase_auth.dart'; 

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Login bem-sucedido!";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Nenhum usuário encontrado para este e-mail.";
      } else if (e.code == 'wrong-password') {
        return "Senha incorreta fornecida para este e-mail.";
      } else if (e.code == 'invalid-email') {
        return "O formato do e-mail é inválido.";
      }
      return "Erro de login: ${e.message}";
    } catch (e) {
      return "Ocorreu um erro inesperado: $e";
    }
  }

  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Usuário registrado com sucesso!";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "A senha fornecida é muito fraca.";
      } else if (e.code == 'email-already-in-use') {
        return "Já existe uma conta para este e-mail.";
      } else if (e.code == 'invalid-email') {
        return "O formato do e-mail é inválido.";
      }
      return "Erro de registro: ${e.message}";
    } catch (e) {
      return "Ocorreu um erro inesperado: $e";
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get userChanges => _firebaseAuth.authStateChanges();
}
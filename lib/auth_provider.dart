// lib/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _rememberMe = false;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  bool get rememberMe => _rememberMe;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setRememberMe(bool novoValor) {
    _rememberMe = novoValor;
    notifyListeners();
  }

  // FUNÇÃO 1: CRIAR CONTA (Sign Up)
  Future<void> signUp(
      String email, String password, {VoidCallback? onSuccess}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      onSuccess?.call();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _errorMessage = 'A senha é muito fraca.';
      } else if (e.code == 'email-already-in-use') {
        _errorMessage = 'Este email já está em uso.';
      } else {
        _errorMessage = 'Ocorreu um erro: ${e.message}';
      }
    } catch (e) {
      _errorMessage = 'Ocorreu um erro inesperado.';
    }

    _isLoading = false;
    notifyListeners();
  }

  // FUNÇÃO 2: ENTRAR (Sign In / Login)
  Future<void> signIn(
      String email, String password, {VoidCallback? onSuccess}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      onSuccess?.call();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        _errorMessage = 'Senha incorreta. Tente novamente.';
      } else if (e.code == 'invalid-credential') {
        _errorMessage = 'Credenciais inválidas. Verifique seu email e senha.';
      } else if (e.code == 'too-many-requests') {
        _errorMessage = 'Muitas tentativas. Tente novamente mais tarde.';
      } else {
        _errorMessage = 'Ocorreu um erro: ${e.message}';
      }
    } catch (e) {
      _errorMessage = 'Ocorreu um erro inesperado.';
    }

    _isLoading = false;
    notifyListeners();
  }

  // FUNÇÃO 3: SAIR (Sign Out / Logout)
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }
}

// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _keyRememberMe = 'remember_me';
const _keyEmail = 'saved_email';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _rememberMe = false;
  bool _isLoading = false;
  String? _errorMessage;
  String _savedEmail = '';

  // Getters
  bool get rememberMe => _rememberMe;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get savedEmail => _savedEmail;

  AuthProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _rememberMe = prefs.getBool(_keyRememberMe) ?? false;
    _savedEmail = _rememberMe ? (prefs.getString(_keyEmail) ?? '') : '';
    notifyListeners();
  }

  Future<void> setRememberMe(bool novoValor) async {
    _rememberMe = novoValor;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRememberMe, novoValor);
    if (!novoValor) {
      await prefs.remove(_keyEmail);
      _savedEmail = '';
    }
    notifyListeners();
  }

  Future<void> _persistEmailIfNeeded(String email) async {
    if (_rememberMe) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyEmail, email);
      _savedEmail = email;
    }
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
      await _persistEmailIfNeeded(email.trim());
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
      await _persistEmailIfNeeded(email.trim());
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

import 'package:flutter/material.dart';
import '../model/user_model.dart';

enum AuthState { initial, loading, success, error }

class AuthViewModel extends ChangeNotifier {
  AuthState _state = AuthState.initial;
  String? _errorMessage;
  UserModel? _user;

  AuthState get state => _state;
  bool get isLoading => _state == AuthState.loading;
  bool get isSuccess => _state == AuthState.success;
  bool get isError => _state == AuthState.error;
  String? get errorMessage => _errorMessage;
  UserModel? get user => _user;

  // Credenciales hardcodeadas requeridas para S9
  static const String _hardcodedDni = '12345678';
  static const String _hardcodedPass = '123456';
  static const String _hardcodedName = 'Aldo Alexandre Requena Lavi';

  Future<bool> login(String dni, String password) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    // Simulamos un retraso de red de 1.5 segundos para mejorar la experiencia de usuario (loading state)
    await Future.delayed(const Duration(milliseconds: 1500));

    if (dni == _hardcodedDni && password == _hardcodedPass) {
      _user = UserModel(
        dni: _hardcodedDni,
        fullName: _hardcodedName,
        email: 'aldo.rojas@cajaarequipa.pe',
        token: 'mock_jwt_token_caja_arequipa_2026',
      );
      _state = AuthState.success;
      notifyListeners();
      return true;
    } else {
      _state = AuthState.error;
      if (dni.length != 8) {
        _errorMessage = 'El DNI debe tener exactamente 8 dígitos.';
      } else if (password.isEmpty) {
        _errorMessage = 'Por favor, ingrese su contraseña.';
      } else {
        _errorMessage = 'DNI o contraseña incorrectos. Intente de nuevo.';
      }
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _state = AuthState.initial;
    _user = null;
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    if (_state == AuthState.error) {
      _state = AuthState.initial;
      _errorMessage = null;
      notifyListeners();
    }
  }
}

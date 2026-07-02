import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  // Credenciales hardcodeadas requeridas por defecto
  static const String _hardcodedDni = '12345678';
  static const String _hardcodedPass = '123456';
  static const String _hardcodedName = 'Aldo Alexandre Requena Lavi';

  Future<bool> login(String dni, String password) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    // Simulamos un retraso de red de 1.5 segundos para mejorar la experiencia de usuario (loading state)
    await Future.delayed(const Duration(milliseconds: 1500));

    // 1. Intentar validar contra Firestore (permite iniciar sesión con cualquiera de los 30 casos)
    try {
      final clientDoc = await FirebaseFirestore.instance.collection('clients').doc(dni).get();
      if (clientDoc.exists && (password == '123456' || (dni == _hardcodedDni && password == _hardcodedPass))) {
        final data = clientDoc.data()!;
        _user = UserModel(
          dni: dni,
          fullName: data['name'] ?? 'Cliente',
          email: data['email'] ?? 'aldorequena@outlook.com', // Correo solicitado por el usuario
          token: 'mock_jwt_token_caja_arequipa_2026',
        );
        _state = AuthState.success;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Error al consultar cliente en Firestore: $e');
    }

    // 2. Fallback para credenciales hardcodeadas por defecto
    if (dni == _hardcodedDni && password == _hardcodedPass) {
      _user = UserModel(
        dni: _hardcodedDni,
        fullName: _hardcodedName,
        email: 'aldorequena@outlook.com',
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

  bool validateCredentials(String dni, String password) {
    if (_user == null) return false;
    return dni == _user!.dni && (password == '123456' || (dni == _hardcodedDni && password == _hardcodedPass));
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

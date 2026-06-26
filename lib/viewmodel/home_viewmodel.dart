import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/product_model.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = false;
  SavingsAccount? _savingsAccount;
  CreditProduct? _creditProduct;
  List<BankTransaction> _transactions = [];

  // Para las solicitudes de crédito
  List<Map<String, dynamic>> _pendingRequests = [];
  StreamSubscription<DocumentSnapshot>? _clientSub;
  StreamSubscription<QuerySnapshot>? _requestsSub;
  String? _currentDni;

  bool get isLoading => _isLoading;
  SavingsAccount? get savingsAccount => _savingsAccount;
  CreditProduct? get creditProduct => _creditProduct;
  List<BankTransaction> get transactions => _transactions;
  List<Map<String, dynamic>> get pendingRequests => _pendingRequests;

  @override
  void dispose() {
    _clientSub?.cancel();
    _requestsSub?.cancel();
    super.dispose();
  }

  Future<void> fetchDashboardData() async {
    if (_currentDni == null) {
      await listenToClientData('12345678');
    }
  }

  Future<void> listenToClientData(String dni) async {
    _currentDni = dni;
    _isLoading = true;
    notifyListeners();

    // Cancelar suscripciones previas si las hay
    await _clientSub?.cancel();
    await _requestsSub?.cancel();

    // 1. Escuchar el documento del cliente en Firestore
    _clientSub = FirebaseFirestore.instance
        .collection('clients')
        .doc(dni)
        .snapshots()
        .listen((doc) {
      if (doc.exists) {
        final data = doc.data()!;
        final double savingsBalance = (data['savings_balance'] as num?)?.toDouble() ?? 2000.0;
        final double currentLoanBalance = (data['current_loan_balance'] as num?)?.toDouble() ?? 0.0;

        _savingsAccount = SavingsAccount(
          accountNumber: '191-482910-0-28',
          cci: '002-191-00482910028-54',
          balance: savingsBalance,
        );

        if (currentLoanBalance > 0.0) {
          _creditProduct = CreditProduct(
            productName: 'Crédito Aprobado',
            contractNumber: 'CRE-982710-C',
            totalDebt: currentLoanBalance,
            pendingInstallment: currentLoanBalance / 12, // Simulamos 12 cuotas
            dueDate: '15 Jul 2026',
          );
        } else {
          _creditProduct = null;
        }
      } else {
        _savingsAccount = SavingsAccount(
          accountNumber: '191-482910-0-28',
          cci: '002-191-00482910028-54',
          balance: 2000.0,
        );
        _creditProduct = null;
      }
      _isLoading = false;
      notifyListeners();
    }, onError: (err) {
      debugPrint('Error listening to client doc: $err');
      _isLoading = false;
      notifyListeners();
    });

    // 2. Escuchar las solicitudes de crédito activas del cliente
    _requestsSub = FirebaseFirestore.instance
        .collection('credit_requests')
        .where('dni', isEqualTo: dni)
        .snapshots()
        .listen((snapshot) {
      _pendingRequests = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
      notifyListeners();
    }, onError: (err) {
      debugPrint('Error listening to credit requests: $err');
    });

    // Transacciones simuladas
    _transactions = [
      BankTransaction(
        id: 'TXN001',
        description: 'Transferencia Recibida de Juan Pérez',
        amount: 850.00,
        date: 'Hoy, 10:15 AM',
        isIncome: true,
      ),
      BankTransaction(
        id: 'TXN002',
        description: 'Pago de Servicio Claro Hogar',
        amount: 129.90,
        date: 'Ayer, 04:30 PM',
        isIncome: false,
      ),
      BankTransaction(
        id: 'TXN003',
        description: 'Retiro de Efectivo Cajero Caja Arequipa',
        amount: 200.00,
        date: '23 Jun 2026',
        isIncome: false,
      ),
      BankTransaction(
        id: 'TXN004',
        description: 'Abono de Intereses Cuenta Ahorro',
        amount: 15.20,
        date: '20 Jun 2026',
        isIncome: true,
      ),
      BankTransaction(
        id: 'TXN005',
        description: 'Compra Supermercados Metro',
        amount: 94.30,
        date: '18 Jun 2026',
        isIncome: false,
      ),
    ];
  }

  Future<void> resetCreditDatabase() async {
    try {
      // 1. Limpiar el balance de crédito del cliente en Firestore
      await FirebaseFirestore.instance.collection('clients').doc('12345678').set({
        'savings_balance': 2000.0,
        'current_loan_balance': 0.0,
      }, SetOptions(merge: true));

      // 2. Eliminar todas las solicitudes de crédito previas para este cliente
      final requests = await FirebaseFirestore.instance
          .collection('credit_requests')
          .where('dni', isEqualTo: '12345678')
          .get();

      for (var doc in requests.docs) {
        await doc.reference.delete();
      }
      
      debugPrint('Database reset completed successfully for client 12345678.');
    } catch (e) {
      debugPrint('Error resetting credit database: $e');
    }
  }

  Future<String?> solicitarCredito({
    required String clientName,
    required String creditType,
    required double amount,
    required int termMonths,
  }) async {
    if (_currentDni == null) return null;

    try {
      final docRef = await FirebaseFirestore.instance.collection('credit_requests').add({
        'dni': _currentDni,
        'client_name': clientName,
        'credit_type': creditType,
        'amount': amount,
        'term_months': termMonths,
        'status': 'Pendiente',
        'request_date': FieldValue.serverTimestamp(),
      });
      final shortId = docRef.id.substring(docRef.id.length - 6).toUpperCase();
      return 'EXP-2026-$shortId';
    } catch (e) {
      debugPrint('Error creating credit request: $e');
      return null;
    }
  }

  Future<void> cancelarSolicitud(String requestId) async {
    try {
      await FirebaseFirestore.instance.collection('credit_requests').doc(requestId).delete();
    } catch (e) {
      debugPrint('Error deleting credit request: $e');
    }
  }
}

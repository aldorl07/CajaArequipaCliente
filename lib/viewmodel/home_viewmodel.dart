import 'package:flutter/material.dart';
import '../model/product_model.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = false;
  SavingsAccount? _savingsAccount;
  CreditProduct? _creditProduct;
  List<BankTransaction> _transactions = [];

  bool get isLoading => _isLoading;
  SavingsAccount? get savingsAccount => _savingsAccount;
  CreditProduct? get creditProduct => _creditProduct;
  List<BankTransaction> get transactions => _transactions;

  Future<void> fetchDashboardData() async {
    _isLoading = true;
    notifyListeners();

    // Simulamos carga de datos del Dashboard en 1 segundo
    await Future.delayed(const Duration(milliseconds: 1000));

    // Datos ficticios pero realistas de Caja Arequipa
    _savingsAccount = SavingsAccount(
      accountNumber: '191-482910-0-28',
      cci: '002-191-00482910028-54',
      balance: 4850.75,
    );


    // El cliente no tiene créditos activos
    _creditProduct = null;


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

    _isLoading = false;
    notifyListeners();
  }
}

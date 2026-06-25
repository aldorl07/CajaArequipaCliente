class SavingsAccount {
  final String accountNumber;
  final String cci;
  final double balance;
  final String currency;

  SavingsAccount({
    required this.accountNumber,
    required this.cci,
    required this.balance,
    this.currency = 'S/',
  });
}

class CreditProduct {
  final String productName;
  final String contractNumber;
  final double totalDebt;
  final double pendingInstallment;
  final String dueDate;
  final String currency;

  CreditProduct({
    required this.productName,
    required this.contractNumber,
    required this.totalDebt,
    required this.pendingInstallment,
    required this.dueDate,
    this.currency = 'S/',
  });
}

class BankTransaction {
  final String id;
  final String description;
  final double amount;
  final String date;
  final bool isIncome;

  BankTransaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.isIncome,
  });
}

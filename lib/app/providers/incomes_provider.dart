import 'package:arqueo_ahsc/app/models/income.dart';
import 'package:flutter/material.dart';

class IncomesProvider extends ChangeNotifier {
  final List<Income> _incomes = [
    Income(id: '1', amount: 200.32, description: 'Venta de pan'),
  ];

  List<Income> get incomes => _incomes;

  void addIncome(Income income) {
    _incomes.add(income);

    notifyListeners();
  }

  void removeIncome(String id) {
    _incomes.removeWhere((income) => income.id == id);

    notifyListeners();
  }

  void updateIncomeAmount(String id, double amount) {
    final index = _incomes.indexWhere((element) => element.id == id);

    _incomes[index].amount = amount;

    notifyListeners();
  }
}
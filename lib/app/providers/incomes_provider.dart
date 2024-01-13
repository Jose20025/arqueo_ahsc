import 'package:arqueo_ahsc/app/models/income.dart';
import 'package:flutter/material.dart';

class IncomesProvider extends ChangeNotifier {
  final List<Income> _incomes = [];

  List<Income> get incomes => _incomes;

  void addIncome(Income income) {
    _incomes.add(income);

    notifyListeners();
  }

  void removeIncome(String id) {
    _incomes.removeWhere((income) => income.id == id);

    notifyListeners();
  }

  void updateIncome(String id, Income newIncome) {
    final index = _incomes.indexWhere((income) => income.id == id);

    _incomes[index] = newIncome;

    notifyListeners();
  }
}

import 'dart:convert';

import 'package:arqueo_ahsc/app/models/income.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomesProvider extends ChangeNotifier {
  final List<Income> _incomes = [];
  double total = 0;

  List<Income> get incomes => _incomes;

  void loadIncomes() async {
    if (_incomes.isNotEmpty) return;

    final sharedPrefs = await SharedPreferences.getInstance();

    final List<String> incomesString =
        sharedPrefs.getStringList('incomes') ?? [];

    _incomes.clear();

    for (var incomeString in incomesString) {
      final Income income = Income.fromJson(jsonDecode(incomeString));

      _incomes.add(income);

      total += income.amount;
    }

    notifyListeners();
  }

  void cleanIncomes() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    sharedPrefs.remove('incomes');

    _incomes.clear();

    total = 0;

    notifyListeners();
  }

  void saveIncomes() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    final List<String> incomesString =
        _incomes.map((income) => jsonEncode(income.toJson())).toList();

    sharedPrefs.setStringList('incomes', incomesString);
  }

  void addIncome(Income income) {
    _incomes.add(income);

    saveIncomes();

    total += income.amount;

    notifyListeners();
  }

  void removeIncome(String id) {
    total -= _incomes.firstWhere((income) => income.id == id).amount;

    _incomes.removeWhere((income) => income.id == id);

    saveIncomes();

    notifyListeners();
  }

  void updateIncome(String id, Income newIncome) {
    final index = _incomes.indexWhere((income) => income.id == id);

    total -= _incomes[index].amount;

    _incomes[index] = newIncome;

    total += newIncome.amount;

    saveIncomes();

    notifyListeners();
  }
}

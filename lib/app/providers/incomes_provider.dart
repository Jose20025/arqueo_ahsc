import 'dart:convert';

import 'package:arqueo_ahsc/app/models/income.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomesProvider extends ChangeNotifier {
  final List<Income> _incomes = [];

  List<Income> get incomes => _incomes;

  void loadIncomes() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    final List<String> incomesString =
        sharedPrefs.getStringList('incomes') ?? [];

    _incomes.clear();

    for (var incomeString in incomesString) {
      final Income income = Income.fromJson(jsonDecode(incomeString));

      _incomes.add(income);
    }

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

    notifyListeners();
  }

  void removeIncome(String id) {
    _incomes.removeWhere((income) => income.id == id);

    saveIncomes();

    notifyListeners();
  }

  void updateIncome(String id, Income newIncome) {
    final index = _incomes.indexWhere((income) => income.id == id);

    _incomes[index] = newIncome;

    saveIncomes();

    notifyListeners();
  }
}

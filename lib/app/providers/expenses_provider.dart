import 'dart:convert';

import 'package:arqueo_ahsc/app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesProvider extends ChangeNotifier {
  final List<Expense> _expenses = [];
  double total = 0;

  List<Expense> get expenses => _expenses;

  void loadExpenses() async {
    if (_expenses.isNotEmpty) return;

    final sharedPrefs = await SharedPreferences.getInstance();

    final List<String> expensesString =
        sharedPrefs.getStringList('expenses') ?? [];

    _expenses.clear();

    for (var expenseString in expensesString) {
      final Expense expense = Expense.fromJson(jsonDecode(expenseString));

      _expenses.add(expense);

      total += expense.amount;
    }

    notifyListeners();
  }

  void cleanExpenses() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    sharedPrefs.remove('expenses');

    _expenses.clear();

    total = 0;

    notifyListeners();
  }

  void saveExpenses() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    final List<String> expensesString =
        _expenses.map((expense) => jsonEncode(expense.toJson())).toList();

    sharedPrefs.setStringList('expenses', expensesString);
  }

  void addExpense(Expense expense) {
    _expenses.add(expense);

    saveExpenses();

    total += expense.amount;

    notifyListeners();
  }

  void removeExpense(String id) {
    total -= _expenses.firstWhere((expense) => expense.id == id).amount;

    _expenses.removeWhere((expense) => expense.id == id);

    saveExpenses();

    notifyListeners();
  }

  void editExpense(String id, Expense expense) {
    final index = _expenses.indexWhere((expense) => expense.id == id);

    total -= _expenses[index].amount;

    _expenses[index] = expense;

    total += expense.amount;

    saveExpenses();

    notifyListeners();
  }
}

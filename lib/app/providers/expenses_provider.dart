import 'package:arqueo_ahsc/app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesProvider extends ChangeNotifier {
  final List<Expense> _expenses = [
    Expense(
      id: '1',
      description: 'Gasto 1',
      amount: 100,
    ),
    Expense(
      id: '2',
      description: 'Gasto 2',
      amount: 200,
    ),
    Expense(
      id: '3',
      description: 'Gasto 3',
      amount: 300,
    ),
  ];

  List<Expense> get expenses => _expenses;

  void addExpense(Expense expense) {
    _expenses.add(expense);

    notifyListeners();
  }

  void removeExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);

    notifyListeners();
  }

  void editExpense(String id, Expense expense) {
    final index = _expenses.indexWhere((expense) => expense.id == id);

    _expenses[index] = expense;

    notifyListeners();
  }
}

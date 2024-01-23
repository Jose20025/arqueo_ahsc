import 'dart:convert';

import 'package:arqueo_ahsc/app/models/cash_count.dart';
import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DayCashCountsProvider extends ChangeNotifier {
  final List<DayCashCount> _dayCashCounts = [];

  List<DayCashCount> get dayCashCounts => _dayCashCounts.reversed.toList();

  void loadDayCashCounts() async {
    if (_dayCashCounts.isNotEmpty) return;

    final sharedPrefs = await SharedPreferences.getInstance();

    final List<String> dayCashCountsString =
        sharedPrefs.getStringList('dayCashCounts') ?? [];

    _dayCashCounts.clear();

    for (var dayCashCountString in dayCashCountsString) {
      final DayCashCount dayCashCount =
          DayCashCount.fromJson(jsonDecode(dayCashCountString));

      _dayCashCounts.add(dayCashCount);
    }

    notifyListeners();
  }

  void saveDayCashCounts() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    final List<String> dayCashCountsString = _dayCashCounts
        .map((dayCashCount) => jsonEncode(dayCashCount.toJson()))
        .toList();

    sharedPrefs.setStringList('dayCashCounts', dayCashCountsString);
  }

  void createDayCashCount(double initialAmount) {
    final DayCashCount newDayCashCount = DayCashCount(
      id: const Uuid().v4(),
      initialAmount: initialAmount,
      date: DateTime.now(),
    );

    _dayCashCounts.add(newDayCashCount);

    saveDayCashCounts();

    notifyListeners();
  }

  void closeDayCashCount(String id, CashCount closedCashCount) {
    final DayCashCount dayCashCount =
        _dayCashCounts.firstWhere((dayCashCount) => dayCashCount.id == id);

    dayCashCount.close(closedCashCount);

    // TODO: Implementar cálculo de diferencia y monto esperado

    saveDayCashCounts();

    notifyListeners();
  }

  void deleteDayCashCount(String id) {
    _dayCashCounts.removeWhere((dayCashCount) => dayCashCount.id == id);

    saveDayCashCounts();

    notifyListeners();
  }

  void updateDayCashCountInitialAmount(String id, double initialAmount) {
    final DayCashCount dayCashCount =
        _dayCashCounts.firstWhere((dayCashCount) => dayCashCount.id == id);

    dayCashCount.updateInitialAmount(initialAmount);

    saveDayCashCounts();

    notifyListeners();
  }

  void updateDayCashCountFinalCashCount(
    String id,
    CashCount finalCashCount,
  ) {
    final DayCashCount dayCashCount =
        _dayCashCounts.firstWhere((dayCashCount) => dayCashCount.id == id);

    dayCashCount.finalCashCount = finalCashCount;

    saveDayCashCounts();

    notifyListeners();
  }
}

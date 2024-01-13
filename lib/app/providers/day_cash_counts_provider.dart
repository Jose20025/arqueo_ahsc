import 'package:arqueo_ahsc/app/models/cash_count.dart';
import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DayCashCountsProvider extends ChangeNotifier {
  final List<DayCashCount> _dayCashCounts = [];

  List<DayCashCount> get dayCashCounts => _dayCashCounts.reversed.toList();

  void createDayCashCount(double initialAmount) {
    final DayCashCount newDayCashCount = DayCashCount(
      id: const Uuid().v4(),
      initialAmount: initialAmount,
      date: DateTime.now(),
    );

    _dayCashCounts.add(newDayCashCount);

    notifyListeners();
  }

  void closeDayCashCount(String id, CashCount closedCashCount) {
    final DayCashCount dayCashCount =
        _dayCashCounts.firstWhere((dayCashCount) => dayCashCount.id == id);

    dayCashCount.close(closedCashCount);

    notifyListeners();
  }

  void removeDayCashCount(DayCashCount dayCashCount) {
    _dayCashCounts.remove(dayCashCount);
    notifyListeners();
  }

  void deleteDayCashCount(String id) {
    _dayCashCounts.removeWhere((dayCashCount) => dayCashCount.id == id);
    notifyListeners();
  }
}

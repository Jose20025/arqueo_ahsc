import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:flutter/material.dart';

class DayCashCountsProvider extends ChangeNotifier {
  final List<DayCashCount> _dayCashCounts = [];

  List<DayCashCount> get dayCashCounts => _dayCashCounts;

  void addDayCashCount(DayCashCount dayCashCount) {
    _dayCashCounts.add(dayCashCount);
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

import 'package:arqueo_ahsc/app/models/cash.dart';
import 'package:flutter/material.dart';

class CashListProvider extends ChangeNotifier {
  List<Cash> cashList = [];

  void addNewCash(Cash cash) {
    cashList.add(cash);
    notifyListeners();
  }

  void removeCash(String id) {
    cashList.removeWhere((cash) => cash.id == id);
    notifyListeners();
  }
}

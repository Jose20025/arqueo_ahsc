import 'dart:convert';

import 'package:arqueo_ahsc/app/models/cash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashListProvider extends ChangeNotifier {
  List<Cash> cashList = [];

  void loadCashList() async {
    if (cashList.isNotEmpty) return;

    final sharedPrefs = await SharedPreferences.getInstance();

    final List<String> cashListString =
        sharedPrefs.getStringList('cashList') ?? [];

    cashList.clear();

    for (var cashString in cashListString) {
      final Cash cash = Cash.fromJson(jsonDecode(cashString));

      cashList.add(cash);
    }

    notifyListeners();
  }

  void saveCashList() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    final List<String> cashListString = cashList.map((cash) {
      return jsonEncode(cash.toJson());
    }).toList();

    sharedPrefs.setStringList('cashList', cashListString);
  }

  void cleanCashList() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    sharedPrefs.remove('cashList');

    cashList.clear();

    notifyListeners();
  }

  void addNewCash(Cash cash) {
    cashList.add(cash);

    saveCashList();

    notifyListeners();
  }

  void removeCash(String id) {
    cashList.removeWhere((cash) => cash.id == id);

    saveCashList();

    notifyListeners();
  }
}

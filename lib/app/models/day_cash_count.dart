import 'package:arqueo_ahsc/app/models/cash_count.dart';

class DayCashCount {
  // Constructor
  DayCashCount({
    required this.id,
    required this.initialCashCount,
    required this.date,
    this.finalCashCount,
  });

  // Propiedades
  final String id;
  CashCount initialCashCount;
  CashCount? finalCashCount;
  final DateTime date;

  void setFinalCashCount(CashCount finalCashCount) {
    this.finalCashCount = finalCashCount;
  }

  void setInitialCashCount(CashCount initialCashCount) {
    this.initialCashCount = initialCashCount;
  }

  factory DayCashCount.fromJson(Map<String, dynamic> json) {
    return DayCashCount(
      id: json['id'],
      initialCashCount: CashCount.fromJson(json['initialCashCount']),
      finalCashCount: json['finalCashCount'] != null
          ? CashCount.fromJson(json['finalCashCount'])
          : null,
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'initialCashCount': initialCashCount.toJson(),
      'finalCashCount': finalCashCount?.toJson(),
      'date': date.toIso8601String(),
    };
  }
}

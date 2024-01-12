import 'package:arqueo_ahsc/app/models/cash_count.dart';

class DayCashCount {
  // Constructor
  DayCashCount({
    required this.id,
    required this.initialAmount,
    required this.date,
    this.finalCashCount,
  });

  // Propiedades
  final String id;
  double initialAmount;
  CashCount? finalCashCount;
  final DateTime date;
  bool isClosed = false;

  void setFinalCashCount(CashCount finalCashCount) {
    this.finalCashCount = finalCashCount;

    isClosed = true;
  }

  void setInitialCashCount(double initialAmount) {
    this.initialAmount = initialAmount;
  }

  factory DayCashCount.fromJson(Map<String, dynamic> json) {
    return DayCashCount(
      id: json['id'],
      initialAmount: double.parse(json['initialAmount']),
      finalCashCount: json['finalCashCount'] != null
          ? CashCount.fromJson(json['finalCashCount'])
          : null,
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'initialCashCount': initialAmount.toString(),
      'finalCashCount': finalCashCount?.toJson(),
      'date': date.toIso8601String(),
    };
  }
}

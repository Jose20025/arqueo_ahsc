import 'package:arqueo_ahsc/app/models/cash_count.dart';

class DayCashCount {
  // Constructor
  DayCashCount({
    required this.id,
    required this.initialAmount,
    required this.date,
    this.finalCashCount,
    this.isClosed = false,
  });

  // Propiedades
  final String id;
  double initialAmount;
  CashCount? finalCashCount;
  final DateTime date;
  bool isClosed;

  void close(CashCount finalCashCount) {
    this.finalCashCount = finalCashCount;

    isClosed = true;
  }

  void updateInitialAmount(double initialAmount) {
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
      isClosed: json['isClosed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'initialAmount': initialAmount.toString(),
      'finalCashCount': finalCashCount?.toJson(),
      'date': date.toIso8601String(),
      'isClosed': isClosed,
    };
  }
}

import 'package:arqueo_ahsc/app/models/cash_count.dart';
import 'package:arqueo_ahsc/app/models/expense.dart';
import 'package:arqueo_ahsc/app/models/income.dart';

class DayCashCount {
  // Constructor
  DayCashCount({
    required this.id,
    required this.initialAmount,
    required this.date,
    this.finalCashCount,
    this.isClosed = false,
    this.difference = 0,
    this.expectedAmount = 0,
  });

  // Propiedades
  final String id;
  double initialAmount;
  CashCount? finalCashCount;
  final DateTime date;
  bool isClosed;
  double difference;
  double expectedAmount;

  bool get isExpectedAmountOk => difference == 0;
  bool get isMoneyMissing => difference < 0;

  void close(CashCount finalCashCount) {
    this.finalCashCount = finalCashCount;

    isClosed = true;
  }

  void updateInitialAmount(double initialAmount) {
    this.initialAmount = initialAmount;
  }

  void calculateExpectedAmount(List<Income> incomes, List<Expense> expenses) {
    expectedAmount = initialAmount;

    for (final income in incomes) {
      expectedAmount += income.amount;
    }

    for (final expense in expenses) {
      expectedAmount -= expense.amount;
    }

    difference = finalCashCount!.totalAmount - expectedAmount;
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
      difference: json['difference'] ?? 0,
      expectedAmount: json['expectedAmount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'initialAmount': initialAmount.toString(),
      'finalCashCount': finalCashCount?.toJson(),
      'date': date.toIso8601String(),
      'isClosed': isClosed,
      'difference': difference,
      'expectedAmount': expectedAmount,
    };
  }
}

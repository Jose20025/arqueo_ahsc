class CashCount {
  // Constructor
  CashCount({
    required this.totalAmount,
    this.cash10,
    this.cash20,
    this.cash50,
    this.cash100,
    this.cash200,
    this.coin0_5,
    this.coin1,
    this.coin2,
    this.coin5,
    this.bruteCash,
  });

  // Dinero total
  double totalAmount;

  // Billetes
  final int? cash10;
  final int? cash20;
  final int? cash50;
  final int? cash100;
  final int? cash200;

  // Monedas
  final int? coin0_5;
  final int? coin1;
  final int? coin2;
  final int? coin5;

  // Dinero bruto
  double? bruteCash;

  void setTotalAmount(double amount) {
    totalAmount = amount;
  }

  factory CashCount.fromJson(Map<String, dynamic> json) => CashCount(
        cash10: json["cash10"],
        cash20: json["cash20"],
        cash50: json["cash50"],
        cash100: json["cash100"],
        cash200: json["cash200"],
        coin0_5: json["coin0_5"],
        coin1: json["coin1"],
        coin2: json["coin2"],
        coin5: json["coin5"],
        bruteCash: json["bruteCash"],
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "cash10": cash10,
        "cash20": cash20,
        "cash50": cash50,
        "cash100": cash100,
        "cash200": cash200,
        "coin0_5": coin0_5,
        "coin1": coin1,
        "coin2": coin2,
        "coin5": coin5,
        "bruteCash": bruteCash,
        "totalAmount": totalAmount,
      };
}

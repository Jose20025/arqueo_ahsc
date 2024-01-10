class CashCount {
  // Constructor
  CashCount({
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
  }) {
    // Calculamos el dinero total
    totalAmount = 0;
    totalAmount += (cash10 ?? 0) * 10;
    totalAmount += (cash20 ?? 0) * 20;
    totalAmount += (cash50 ?? 0) * 50;
    totalAmount += (cash100 ?? 0) * 100;
    totalAmount += (cash200 ?? 0) * 200;
    totalAmount += (coin0_5 ?? 0) * 0.5;
    totalAmount += (coin1 ?? 0) * 1;
    totalAmount += (coin2 ?? 0) * 2;
    totalAmount += (coin5 ?? 0) * 5;
  }

  // Dinero total
  double totalAmount = 0;

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
      };
}

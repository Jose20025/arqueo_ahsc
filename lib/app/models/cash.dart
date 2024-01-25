class Cash {
  Cash({
    required this.id,
    required this.name,
    required this.amount,
    required this.total,
  });

  final String id;
  final String name;
  final int amount;
  final double total;

  factory Cash.fromJson(Map<String, dynamic> json) => Cash(
        id: json['id'],
        name: json['name'],
        amount: json['amount'],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'amount': amount,
        'total': total,
      };
}

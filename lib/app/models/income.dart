class Income {
  Income({
    required this.id,
    required this.amount,
    this.description,
  });

  final String id;
  double amount;
  String? description;

  factory Income.fromJson(Map<String, dynamic> json) => Income(
        id: json['id'],
        amount: json['amount'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'description': description,
      };
}

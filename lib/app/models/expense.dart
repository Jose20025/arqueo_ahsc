class Expense {
  Expense({
    required this.id,
    required this.description,
    required this.amount,
  });

  final String id;
  String description;
  double amount;

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json['id'],
        description: json['description'],
        amount: json['amount'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'amount': amount,
      };
}

import 'package:arqueo_ahsc/app/models/expense.dart';
import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/widgets/expense/edit_expense_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpenseCardTile extends StatelessWidget {
  const ExpenseCardTile(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.grey, width: 1),
      ),
      surfaceTintColor: Colors.red,
      child: ListTile(
          title: Text(
            NumberFormat.currency().format(expense.amount),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(expense.description),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Eliminar gasto'),
                  content: const Text('¿Está seguro de eliminar el gasto?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<ExpensesProvider>()
                            .removeExpense(expense.id);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Eliminar'),
                    ),
                  ],
                ),
              );
            },
          ),
          onTap: () => showEditExpenseModal(context, expense)),
    );
  }
}

import 'package:arqueo_ahsc/app/models/income.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:arqueo_ahsc/app/widgets/income/edit_income_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IncomeCardTile extends StatelessWidget {
  const IncomeCardTile(this.income, {super.key});

  final Income income;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.blue.withOpacity(0.5),
          width: 1,
        ),
      ),
      surfaceTintColor: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: ListTile(
          title: Text(
            NumberFormat.currency().format(income.amount),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(income.description ?? 'Sin descripción'),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.blue,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Eliminar ingreso'),
                  content:
                      const Text('¿Estás seguro de eliminar este ingreso?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<IncomesProvider>().removeIncome(income.id);
                      },
                      child: const Text('Eliminar'),
                    ),
                  ],
                ),
              );
            },
          ),
          onTap: () => showEditIncomeModal(context, income),
        ),
      ),
    );
  }
}

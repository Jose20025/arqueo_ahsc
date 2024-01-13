import 'package:arqueo_ahsc/app/models/income.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CustomIncomeTile extends StatelessWidget {
  const CustomIncomeTile(this.income, {super.key});

  final Income income;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(income.description ?? ''),
      subtitle: Text(NumberFormat.currency().format(income.amount)),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Eliminar ingreso'),
              content: const Text('¿Estás seguro de eliminar este ingreso?'),
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
    );
  }
}

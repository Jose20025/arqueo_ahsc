import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OperationsSummary extends StatelessWidget {
  const OperationsSummary(this.dayCashCount, {super.key});

  final DayCashCount dayCashCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Desglose de Operaciones',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Card(
          surfaceTintColor: Colors.blue,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.attach_money,
                  color: Colors.green,
                ),
                title: const Text('Ingresos totales'),
                trailing: Text(
                  NumberFormat.currency()
                      .format(context.read<IncomesProvider>().total),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.green,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.money_off,
                  color: Colors.red,
                ),
                title: const Text('Gastos totales'),
                trailing: Text(
                  NumberFormat.currency()
                      .format(context.read<ExpensesProvider>().total),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.red,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.balance_rounded,
                  color: Colors.green,
                ),
                title: const Text("Total"),
                subtitle: const Text('Ingresos - Gastos'),
                trailing: Text(
                  NumberFormat.currency().format(
                      context.read<IncomesProvider>().total -
                          context.read<ExpensesProvider>().total),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.green,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.attach_money,
                  color: Colors.green,
                ),
                title: const Text('Monto Inicial'),
                trailing: Text(
                  NumberFormat.currency().format(dayCashCount.initialAmount),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.attach_money,
                  color: Colors.blue,
                ),
                title: const Text('Lo que debería haber en caja'),
                subtitle: const Text('Monto inicial + Total'),
                trailing: Text(
                  NumberFormat.currency().format(dayCashCount.expectedAmount),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.attach_money,
                  color: Colors.green,
                ),
                title: const Text('Lo que hay en caja'),
                trailing: Text(
                  NumberFormat.currency()
                      .format(dayCashCount.finalCashCount!.totalAmount),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/models/expense.dart';
import 'package:arqueo_ahsc/app/models/income.dart';
import 'package:arqueo_ahsc/app/pages/close_day_cash_count_page.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CloseCashCountButton extends StatelessWidget {
  const CloseCashCountButton(this.dayCashCount, {super.key});

  final DayCashCount dayCashCount;

  final buttonStyle = const ButtonStyle(
      // backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
      // surfaceTintColor: MaterialStatePropertyAll(Colors.blue),
      );

  @override
  Widget build(BuildContext context) {
    return dayCashCount.isClosed
        ? FilledButton.icon(
            onPressed: () {
              final List<Income> incomes =
                  context.read<IncomesProvider>().incomes;
              final List<Expense> expenses =
                  context.read<ExpensesProvider>().expenses;

              context
                  .read<DayCashCountsProvider>()
                  .recalculateExpectedAmountAndDifference(
                      dayCashCount.id, incomes, expenses);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Se ha recalculado el arqueo',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 2),
                  showCloseIcon: true,
                  closeIconColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: const Icon(Icons.restore),
            label: const Text('Recalcular'),
          )
        : FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CloseDayCashCountPage(),
                ),
              );
            },
            style: buttonStyle,
            label: const Text('Cerrar arqueo'),
            icon: const Icon(Icons.no_encryption_gmailerrorred_outlined),
          );
  }
}

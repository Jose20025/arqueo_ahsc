import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/models/expense.dart';
import 'package:arqueo_ahsc/app/models/income.dart';
import 'package:arqueo_ahsc/app/pages/close_day_cash_count_page.dart';
import 'package:arqueo_ahsc/app/pages/details_page.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:arqueo_ahsc/app/widgets/dayCashCounts/edit_initial_amount_modal.dart';
import 'package:arqueo_ahsc/app/widgets/public/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DayCashCountCard extends StatelessWidget {
  const DayCashCountCard(
    this.dayCashCount, {
    super.key,
  });

  final DayCashCount dayCashCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.attach_money,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Plata en caja',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Text(
                        'Estado: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: !dayCashCount.isClosed
                              ? Colors.green
                              : Colors.red,
                        ),
                        child: Text(
                          dayCashCount.isClosed ? 'Cerrado' : 'Abierto',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Inicio',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Fin',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    NumberFormat.currency().format(dayCashCount.initialAmount),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    NumberFormat.currency().format(
                        dayCashCount.finalCashCount == null
                            ? 0
                            : dayCashCount.finalCashCount!.totalAmount),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Icon(
                    Icons.date_range,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Fecha',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    DateFormat.yMMMEd().format(dayCashCount.date),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              _DetailsButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(dayCashCount),
                    ),
                  );
                },
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      _DeleteCashCountButton(dayCashCount),
                      const SizedBox(width: 5),
                      _EditCashCountButton(dayCashCount),
                    ],
                  ),
                  _CloseCashCountButton(dayCashCount),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteCashCountButton extends StatelessWidget {
  const _DeleteCashCountButton(
    this.dayCashCount,
  );

  final DayCashCount dayCashCount;

  final buttonStyle = const ButtonStyle(
      // backgroundColor: MaterialStateProperty.all(Colors.red),
      );

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: buttonStyle,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            onAccept: () {
              context
                  .read<DayCashCountsProvider>()
                  .deleteDayCashCount(dayCashCount.id);
            },
            description: '¿Estás seguro de que quieres eliminar este arqueo?',
          ),
        );
      },
      child: const Icon(Icons.delete),
    );
  }
}

class _EditCashCountButton extends StatelessWidget {
  const _EditCashCountButton(
    this.dayCashCount,
  );

  final DayCashCount dayCashCount;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Editar arqueo'),
              content: const Text('¿Qué arqueo quieres editar?'),
              actions: [
                TextButton(
                  onPressed: () {
                    showEditInitialAmountModal(context, dayCashCount);
                  },
                  child: const Text('Arqueo inicial'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);

                    if (dayCashCount.finalCashCount == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'No se puede editar el arqueo final porque no se ha realizado',
                            style: TextStyle(color: Colors.white),
                          ),
                          duration: Duration(seconds: 2),
                          showCloseIcon: true,
                          closeIconColor: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CloseDayCashCountPage(
                          isEdit: true,
                          dayCashCount: dayCashCount,
                        ),
                      ),
                    );
                  },
                  child: const Text('Arqueo Final'),
                )
              ],
            );
          },
        );
      },
      label: const Text('Editar'),
      icon: const Icon(Icons.edit),
    );
  }
}

class _CloseCashCountButton extends StatelessWidget {
  const _CloseCashCountButton(
    this.dayCashCount,
  );

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

class _DetailsButton extends StatelessWidget {
  const _DetailsButton({required this.onPressed});

  final void Function() onPressed;

  final buttonStyle = const ButtonStyle(
      // backgroundColor: MaterialStateProperty.all(Colors.blue),
      );

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: const Text(
        'Ver detalles',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/pages/close_day_cash_count_page.dart';
import 'package:arqueo_ahsc/app/pages/details_page.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
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
              ListTile(
                leading: const Icon(Icons.attach_money),
                title: const Text('Plata en caja'),
                trailing: dayCashCount.isClosed
                    ? const Icon(Icons.lock, color: Colors.red)
                    : const Icon(Icons.lock_open, color: Colors.green),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Inicio',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Fin',
                    style: TextStyle(fontSize: 18),
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
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    NumberFormat.currency().format(
                        dayCashCount.finalCashCount == null
                            ? 0
                            : dayCashCount.finalCashCount!.totalAmount),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.date_range),
                title: const Text('Fecha'),
                subtitle: Text(
                  DateFormat.yMEd().format(dayCashCount.date),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 5),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _EditCashCountButton(dayCashCount),
                      const SizedBox(width: 10),
                      _CloseCashCountButton(dayCashCount),
                    ],
                  ),
                  _DeleteCashCountButton(dayCashCount)
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
      // foregroundColor: MaterialStateProperty.all(Colors.white),
      // backgroundColor: MaterialStateProperty.all(Colors.red),
      );

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
      icon: const Icon(Icons.delete),
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
    return FilledButton(
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
        child: const Text('Editar'));
  }
}

class _CloseCashCountButton extends StatelessWidget {
  _CloseCashCountButton(
    this.dayCashCount,
  );

  final DayCashCount dayCashCount;

  final buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.green),
  );

  @override
  Widget build(BuildContext context) {
    return dayCashCount.isClosed
        ? const SizedBox.shrink()
        : FilledButton.tonal(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CloseDayCashCountPage(),
                ),
              );
            },
            style: buttonStyle,
            child: const Text('Cerrar arqueo'),
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

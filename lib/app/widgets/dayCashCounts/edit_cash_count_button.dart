import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/pages/close_day_cash_count_page.dart';
import 'package:arqueo_ahsc/app/widgets/dayCashCounts/edit_initial_amount_modal.dart';
import 'package:flutter/material.dart';

class EditCashCountButton extends StatelessWidget {
  const EditCashCountButton(this.dayCashCount, {super.key});

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

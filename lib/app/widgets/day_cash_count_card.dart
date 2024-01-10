import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
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
    return SizedBox(
      child: Column(
        children: [
          Card(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ListTile(
                    leading: Icon(Icons.attach_money),
                    title: Text('Plata en caja'),
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
                        NumberFormat.currency()
                            .format(dayCashCount.initialCashCount.totalAmount),
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
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 5),
                  FilledButton(
                    onPressed: () {
                      // TODO: Implementar ver detalles
                    },
                    child: const Text(
                      'Ver detalles',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilledButton.tonal(
                        onPressed: dayCashCount.finalCashCount == null
                            ? () {
                                // TODO: Implementar cierre de arqueo
                              }
                            : null,
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(1),
                        ),
                        child: const Text('Cerrar arqueo'),
                      ),
                      FilledButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Editar arqueo'),
                                    content: const Text(
                                        '¿Qué arqueo quieres editar?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            // TODO: Implementar edición de arqueo inicial
                                          },
                                          child: const Text('Arqueo inicial')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);

                                            if (dayCashCount.finalCashCount ==
                                                null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'No se puede editar el arqueo final porque no se ha realizado',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  duration:
                                                      Duration(seconds: 2),
                                                  showCloseIcon: true,
                                                  closeIconColor: Colors.white,
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                              return;
                                            }

                                            // TODO: Implementar edición de arqueo final
                                          },
                                          child: const Text('Arqueo Final'))
                                    ],
                                  );
                                });
                          },
                          child: const Text('Editar')),
                      FilledButton.tonalIcon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Eliminar arqueo'),
                              content: const Text(
                                  '¿Está seguro que desea eliminar este arqueo?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context
                                        .read<DayCashCountsProvider>()
                                        .deleteDayCashCount(dayCashCount.id);

                                    Navigator.pop(context);
                                  },
                                  child: const Text('Eliminar'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Eliminar'),
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red)),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/widgets/details/final_cash_count_details.dart';
import 'package:arqueo_ahsc/app/widgets/details/operations_summary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage(this.dayCashCount, {super.key});

  final DayCashCount dayCashCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: const Text('Detalles'),
        centerTitle: true,
      ),

      // Body
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const Divider(),
            const SizedBox(height: 10),
            _DetailsSummary(dayCashCount),

            // Arqueo Final
            if (dayCashCount.isClosed) ...[
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              FinalCashCountDetails(dayCashCount.finalCashCount!),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              OperationsSummary(dayCashCount),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailsSummary extends StatelessWidget {
  const _DetailsSummary(this.dayCashCount);

  final DayCashCount dayCashCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Colors.blue,
          width: 1,
        ),
      ),
      surfaceTintColor: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            // Fecha
            ListTile(
              leading: const Icon(
                Icons.calendar_today,
                color: Colors.blue,
              ),
              title: const Text(
                'Fecha',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Text(
                DateFormat.yMMMMEEEEd().format(dayCashCount.date),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),

            // Estado
            ListTile(
              leading: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              title: const Text(
                'Estado',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Text(
                dayCashCount.isClosed ? 'Cerrado' : 'Sin cerrar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: dayCashCount.isClosed ? Colors.red : Colors.green,
                ),
              ),
            ),

            // Monto Inicial
            ListTile(
              leading: const Icon(
                Icons.attach_money,
                color: Colors.green,
              ),
              title: const Text(
                'Caja Inicial',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Text(
                NumberFormat.currency().format(dayCashCount.initialAmount),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ),

            // Lo que debería haber
            if (dayCashCount.isClosed)
              ListTile(
                leading: const Icon(
                  Icons.question_mark_rounded,
                  color: Colors.blue,
                  size: 20,
                ),
                title: const Text(
                  'Lo que debería haber',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Text(
                  NumberFormat.currency().format(dayCashCount.expectedAmount),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),

            // Monto Final
            dayCashCount.isClosed
                ? ListTile(
                    leading: const Icon(
                      Icons.attach_money,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Lo que hay',
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Text(
                      NumberFormat.currency()
                          .format(dayCashCount.finalCashCount!.totalAmount),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  )
                : const ListTile(
                    leading: Icon(
                      Icons.warning,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                      'No se ha cerrado el arqueo',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

            // Diferencia
            if (dayCashCount.isClosed)
              ListTile(
                leading: Icon(
                  Icons.compare_arrows_rounded,
                  color:
                      dayCashCount.isMoneyMissing ? Colors.red : Colors.green,
                ),
                title: const Text(
                  'Diferencia',
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: dayCashCount.difference != 0
                    ? Text(
                        dayCashCount.isMoneyMissing
                            ? 'Faltó plata'
                            : "Sobró plata",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: dayCashCount.isMoneyMissing
                              ? Colors.red
                              : Colors.green,
                        ),
                      )
                    : null,
                trailing: dayCashCount.difference != 0
                    ? Text(
                        NumberFormat.currency().format(dayCashCount.difference),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: dayCashCount.isMoneyMissing
                              ? Colors.red
                              : Colors.green,
                        ),
                      )
                    : const Text(
                        '😎 Cuadró la caja',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
          ],
        ),
      ),
    );
  }
}

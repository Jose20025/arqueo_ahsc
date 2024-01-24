import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:arqueo_ahsc/app/widgets/details/final_cash_count_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
              FinalCashCountDetails(dayCashCount.finalCashCount!)
            ],

            const SizedBox(height: 10),
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
      surfaceTintColor: Colors.blue,
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
              style: TextStyle(fontSize: 15),
            ),
            trailing: Text(
              DateFormat.yMMMMEEEEd().format(dayCashCount.date),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
              style: TextStyle(fontSize: 15),
            ),
            trailing: Text(
              dayCashCount.isClosed ? 'Cerrado' : 'Sin cerrar',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),

          // Monto Inicial
          ListTile(
            leading: const Icon(
              Icons.attach_money,
              color: Colors.green,
            ),
            title: const Text(
              'Monto Inicial',
              style: TextStyle(fontSize: 15),
            ),
            trailing: Text(
              NumberFormat.currency().format(dayCashCount.initialAmount),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                    'Monto Final',
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: Text(
                    NumberFormat.currency()
                        .format(dayCashCount.finalCashCount!.totalAmount),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                )
              : const ListTile(
                  leading: Icon(
                    Icons.warning,
                    color: Colors.redAccent,
                  ),
                  title: Text(
                    'No se ha cerrado el arqueo',
                    style: TextStyle(fontSize: 15),
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
                style: TextStyle(fontSize: 15),
              ),
              trailing: Text(
                NumberFormat.currency().format(dayCashCount.expectedAmount),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),

          // Diferencia
          if (dayCashCount.isClosed)
            ListTile(
              leading: const Icon(
                Icons.compare_arrows_rounded,
                color: Colors.blue,
                size: 20,
              ),
              title: const Text(
                'Diferencia',
                style: TextStyle(fontSize: 15),
              ),
              trailing: dayCashCount.difference != 0
                  ? Text(
                      NumberFormat.currency().format(dayCashCount.difference),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    )
                  : const Text(
                      '😎 Cuadró la caja',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
            ),

          // Ingresos y Gastos
          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.attach_money,
              color: Colors.green,
            ),
            title: const Text('Ingresos totales'),
            trailing: Text(
              NumberFormat.currency()
                  .format(context.read<IncomesProvider>().total),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

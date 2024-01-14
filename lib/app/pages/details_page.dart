import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(this.dayCashCount, {super.key});

  final DayCashCount dayCashCount;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const Divider(),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Detalles del Arqueo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            _DetailsSummary(widget.dayCashCount),
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
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Fecha'),
            trailing: Text(
              DateFormat.yMMMMEEEEd().format(dayCashCount.date),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Monto Inicial'),
            trailing: Text(
              NumberFormat.currency().format(dayCashCount.initialAmount),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.backup_outlined),
            title: const Text('Monto Final'),
            trailing: Text(
              dayCashCount.finalCashCount == null
                  ? 'No se ha realizado el cierre'
                  : NumberFormat.currency()
                      .format(dayCashCount.finalCashCount!.totalAmount),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

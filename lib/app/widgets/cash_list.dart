import 'package:arqueo_ahsc/app/models/cash.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CashList extends StatelessWidget {
  const CashList(this.cashList, {super.key});

  final List<Cash> cashList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: cashList.isEmpty ? const _NoCash() : _CashList(cashList),
    );
  }
}

class _NoCash extends StatelessWidget {
  const _NoCash();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No hay efectivo\nAgrega uno para empezar',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _CashList extends StatelessWidget {
  const _CashList(
    this.cashList,
  );

  final List<Cash> cashList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) {
        return _CashCard(cashList[index]);
      },
      separatorBuilder: (_, __) => const SizedBox(height: 5),
      itemCount: cashList.length,
    );
  }
}

class _CashCard extends StatelessWidget {
  const _CashCard(this.cash);

  final Cash cash;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(cash.name),
        subtitle: Text('Cantidad: ${cash.amount}'),
        trailing: Text(
          NumberFormat.currency().format(cash.total),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}

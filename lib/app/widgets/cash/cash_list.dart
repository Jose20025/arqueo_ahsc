import 'package:arqueo_ahsc/app/models/cash.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CashList extends StatelessWidget {
  const CashList(this.cashList, {super.key, required this.onDelete});

  final List<Cash> cashList;
  final void Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: cashList.isEmpty
          ? const _NoCash()
          : _CashList(cashList, onDelete: onDelete),
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
  const _CashList(this.cashList, {required this.onDelete});

  final List<Cash> cashList;
  final void Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) {
        return _CashCard(
          cashList[index],
          onDelete: onDelete,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 5),
      itemCount: cashList.length,
    );
  }
}

class _CashCard extends StatelessWidget {
  const _CashCard(this.cash, {required this.onDelete});

  final Cash cash;
  final void Function(String) onDelete;

  void deleteCash(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar efectivo'),
        content: const Text('¿Estás seguro de eliminar este efectivo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
              onPressed: () {
                onDelete(cash.id);

                Navigator.pop(context);
              },
              child: const Text('Eliminar'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(cash.name),
        leading: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
            size: 20,
          ),
          onPressed: () => deleteCash(context),
        ),
        subtitle: Text('Cantidad: ${cash.amount}'),
        trailing: Text(
          NumberFormat.currency().format(cash.total),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}

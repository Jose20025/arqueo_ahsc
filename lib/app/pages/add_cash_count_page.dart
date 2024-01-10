import 'package:arqueo_ahsc/app/helpers/build_error_snack_bar.dart';
import 'package:arqueo_ahsc/app/models/cash.dart';
import 'package:arqueo_ahsc/app/models/cash_count.dart';
import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
import 'package:arqueo_ahsc/app/widgets/cash_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddCashCountPage extends StatefulWidget {
  const AddCashCountPage({super.key});

  @override
  State<AddCashCountPage> createState() {
    print('Me redibujo');
    return _AddCashCountPageState();
  }
}

class _AddCashCountPageState extends State<AddCashCountPage> {
  List<Cash> cashList = [];
  late final DayCashCountsProvider dayCashCountsProvider;

  @override
  void initState() {
    super.initState();
    dayCashCountsProvider = context.read<DayCashCountsProvider>();
  }

  void addNewCash(Cash cash) {
    setState(() {
      cashList.add(cash);
    });
  }

  void addNewDayCashCount() {
    final Map<String, dynamic> amountsMap = {};
    double total = 0;

    for (Cash cash in cashList) {
      switch (cash.name) {
        case 'Billetes de 200':
          if (amountsMap.containsKey('cash200')) {
            amountsMap['cash200'] += cash.amount;
          } else {
            amountsMap['cash200'] = cash.amount;
          }

          total += cash.total;
          break;

        case 'Billetes de 100':
          if (amountsMap.containsKey('cash100')) {
            amountsMap['cash100'] += cash.amount;
          } else {
            amountsMap['cash100'] = cash.amount;
          }

          total += cash.total;
          break;

        case 'Billetes de 50':
          if (amountsMap.containsKey('cash50')) {
            amountsMap['cash50'] += cash.amount;
          } else {
            amountsMap['cash50'] = cash.amount;
          }

          total += cash.total;
          break;

        case 'Billetes de 20':
          if (amountsMap.containsKey('cash20')) {
            amountsMap['cash20'] += cash.amount;
          } else {
            amountsMap['cash20'] = cash.amount;
          }

          total += cash.total;
          break;

        case 'Billetes de 10':
          if (amountsMap.containsKey('cash10')) {
            amountsMap['cash10'] += cash.amount;
          } else {
            amountsMap['cash10'] = cash.amount;
          }

          total += cash.total;
          break;

        case 'Monedas de 5':
          if (amountsMap.containsKey('coin5')) {
            amountsMap['coin5'] += cash.amount;
          } else {
            amountsMap['coin5'] = cash.amount;
          }

          total += cash.total;
          break;

        case 'Monedas de 2':
          if (amountsMap.containsKey('coin2')) {
            amountsMap['coin2'] += cash.amount;
          } else {
            amountsMap['coin2'] = cash.amount;
          }

          total += cash.total;
          break;

        case 'Monedas de 1':
          if (amountsMap.containsKey('coin1')) {
            amountsMap['coin1'] += cash.amount;
          } else {
            amountsMap['coin1'] = cash.amount;
          }

          total += cash.total;
          break;

        case 'Monedas de 0.5':
          if (amountsMap.containsKey('coin05')) {
            amountsMap['coin05'] += cash.amount;
          } else {
            amountsMap['coin05'] = cash.amount;
          }

          total += cash.total;
          break;

        case 'Monto bruto':
          if (amountsMap.containsKey('bruteCash')) {
            amountsMap['bruteCash'] += cash.total;
          } else {
            amountsMap['bruteCash'] = cash.total;
          }

          total += cash.total;
          break;
      }
    }

    final CashCount initialCashCount = CashCount(
      totalAmount: total,
      cash200: amountsMap['cash200'] ?? 0,
      cash100: amountsMap['cash100'] ?? 0,
      cash50: amountsMap['cash50'] ?? 0,
      cash20: amountsMap['cash20'] ?? 0,
      cash10: amountsMap['cash10'] ?? 0,
      coin5: amountsMap['coin5'] ?? 0,
      coin2: amountsMap['coin2'] ?? 0,
      coin1: amountsMap['coin1'] ?? 0,
      coin05: amountsMap['coin05'] ?? 0,
      bruteCash: amountsMap['bruteCash'] ?? 0,
    );

    final newDayCashCount = DayCashCount(
      id: const Uuid().v4(),
      initialCashCount: initialCashCount,
      date: DateTime.now(),
    );

    dayCashCountsProvider.addDayCashCount(newDayCashCount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: const Text('Nuevo arqueo de caja'),
        centerTitle: true,
      ),

      // floatingActionButton
      floatingActionButton: cashList.isNotEmpty
          ? FloatingActionButton(
              onPressed: () => addNewDayCashCount(),
              child: const Icon(Icons.save),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

      // Body
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            CashList(cashList),
            const SizedBox(height: 10),
            _BottomMenu(
              onNewCashAdded: addNewCash,
            )
          ],
        ),
      ),
    );
  }
}

class _BottomMenu extends StatefulWidget {
  const _BottomMenu({required this.onNewCashAdded});

  final Function(Cash) onNewCashAdded;

  @override
  State<_BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<_BottomMenu> {
  final TextEditingController _amountController = TextEditingController();
  String? _selectedOption;

  void changeSelectedOption(String option) {
    setState(() {
      _selectedOption = option;
    });
  }

  void addNewCash() {
    if (_selectedOption == null || _selectedOption!.isEmpty) {
      showErrorSnackBar(context, title: 'Selecciona un tipo de efectivo');
      return;
    }

    if (_amountController.text.isEmpty) {
      showErrorSnackBar(context, title: 'Ingresa un monto');
      return;
    }

    String name = "";

    switch (_selectedOption) {
      case 'cash200':
        name = 'Billetes de 200';
        break;
      case 'cash100':
        name = 'Billetes de 100';
        break;
      case 'cash50':
        name = 'Billetes de 50';
        break;
      case 'cash20':
        name = 'Billetes de 20';
        break;
      case 'cash10':
        name = 'Billetes de 10';
        break;
      case 'coin5':
        name = 'Monedas de 5';
        break;
      case 'coin2':
        name = 'Monedas de 2';
        break;
      case 'coin1':
        name = 'Monedas de 1';
        break;
      case 'coin05':
        name = 'Monedas de 0.5';
        break;
      case 'bruteCash':
        name = 'Monto bruto';
        break;
    }

    Cash? newCash;

    if (_selectedOption == 'bruteCash') {
      final double bruteCash = double.parse(_amountController.text);

      newCash = Cash(
        id: const Uuid().v4(),
        name: name,
        amount: 1,
        total: bruteCash,
      );
    } else {
      double total = 0;
      int amount = int.parse(_amountController.text);

      switch (_selectedOption) {
        case 'cash200':
          total = amount * 200;
          break;
        case 'cash100':
          total = amount * 100;
          break;
        case 'cash50':
          total = amount * 50;
          break;
        case 'cash20':
          total = amount * 20;
          break;
        case 'cash10':
          total = amount * 10;
          break;
        case 'coin5':
          total = amount * 5;
          break;
        case 'coin2':
          total = amount * 2;
          break;
        case 'coin1':
          total = amount * 1;
          break;
        case 'coin05':
          total = amount * 0.5;
          break;
      }

      newCash = Cash(
        id: const Uuid().v4(),
        name: name,
        amount: amount,
        total: total,
      );
    }

    widget.onNewCashAdded(newCash);

    // Ahora limpio los campos
    setState(() {
      _selectedOption = null;
      _amountController.clear();
    });

    // Le quito el focus a los dos campos
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Column(
        children: [
          Row(
            children: [
              // Dropdown button
              _DropdownOptions(
                  onOptionChanged: changeSelectedOption,
                  optionValue: _selectedOption),
              const SizedBox(width: 10),

              // Text field
              _CashField(amountController: _amountController),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Spacer(),
              FilledButton.tonal(
                onPressed: addNewCash,
                child: const Text('Agregar'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _CashField extends StatelessWidget {
  const _CashField({required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Monto',
        ),
        controller: amountController,
      ),
    );
  }
}

// Valores para el dropdown button
const options = [
  DropdownMenuItem(
    value: 'cash200',
    child: Text('Billetes de 200'),
  ),
  DropdownMenuItem(
    value: 'cash100',
    child: Text('Billetes de 100'),
  ),
  DropdownMenuItem(
    value: 'cash50',
    child: Text('Billetes de 50'),
  ),
  DropdownMenuItem(
    value: 'cash20',
    child: Text('Billetes de 20'),
  ),
  DropdownMenuItem(
    value: 'cash10',
    child: Text('Billetes de 10'),
  ),
  DropdownMenuItem(
    value: 'coin5',
    child: Text('Monedas de 5'),
  ),
  DropdownMenuItem(
    value: 'coin2',
    child: Text('Monedas de 2'),
  ),
  DropdownMenuItem(
    value: 'coin1',
    child: Text('Monedas de 1'),
  ),
  DropdownMenuItem(
    value: 'coin05',
    child: Text('Monedas de 0.5'),
  ),
  DropdownMenuItem(
    value: 'bruteCash',
    child: Text('Monto bruto'),
  ),
];

class _DropdownOptions extends StatelessWidget {
  const _DropdownOptions(
      {required this.onOptionChanged, required this.optionValue});

  final Function(String) onOptionChanged;
  final String? optionValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonFormField(
        isExpanded: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Tipo de efectivo',
        ),
        // value: '',
        items: options,
        value: optionValue,
        onChanged: (value) {
          onOptionChanged(value!);
        },
      ),
    );
  }
}

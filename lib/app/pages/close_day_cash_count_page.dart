import 'package:arqueo_ahsc/app/helpers/build_error_snack_bar.dart';
import 'package:arqueo_ahsc/app/helpers/calculate_amounts_map.dart';
import 'package:arqueo_ahsc/app/models/cash.dart';
import 'package:arqueo_ahsc/app/models/cash_count.dart';
import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/models/expense.dart';
import 'package:arqueo_ahsc/app/models/income.dart';
import 'package:arqueo_ahsc/app/providers/cash_list_provider.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:arqueo_ahsc/app/widgets/cash/cash_list.dart';
import 'package:arqueo_ahsc/app/widgets/public/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CloseDayCashCountPage extends StatefulWidget {
  const CloseDayCashCountPage({
    super.key,
    this.isEdit = false,
    this.dayCashCount,
  });

  final bool isEdit;
  final DayCashCount? dayCashCount;

  @override
  State<CloseDayCashCountPage> createState() {
    return _CloseDayCashCountPageState();
  }
}

class _CloseDayCashCountPageState extends State<CloseDayCashCountPage> {
  late CashListProvider cashListProvider;
  late final DayCashCountsProvider dayCashCountsProvider;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    dayCashCountsProvider = context.read<DayCashCountsProvider>();
    cashListProvider = context.read<CashListProvider>();
  }

  void closeDayCashCount() {
    if (cashListProvider.cashList.isEmpty) {
      showErrorSnackBar(context, title: 'Agrega al menos un efectivo');
      return;
    }

    final amountsMap = calculateAmountsMap(cashListProvider.cashList);

    final CashCount closedCashCount = CashCount(
      totalAmount: amountsMap['total'],
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

    if (!widget.isEdit) {
      dayCashCountsProvider.closeDayCashCount(
        context,
        dayCashCountsProvider.dayCashCounts.first.id,
        closedCashCount,
      );

      final List<Income> incomes = context.read<IncomesProvider>().incomes;
      final List<Expense> expenses = context.read<ExpensesProvider>().expenses;

      dayCashCountsProvider.recalculateExpectedAmountAndDifference(
          dayCashCountsProvider.dayCashCounts.first.id, incomes, expenses);
    } else {
      dayCashCountsProvider.updateDayCashCountFinalCashCount(
          widget.dayCashCount!.id, closedCashCount);
    }

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

      // Body
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            CashList(
              scrollController: _scrollController,
              onDelete: (String id) {
                cashListProvider.removeCash(id);
              },
            ),
            const SizedBox(height: 10),
            _BottomMenu(
              onNewCashAdded: (Cash cash) {
                bool canScroll =
                    context.read<CashListProvider>().cashList.isNotEmpty;

                cashListProvider.addNewCash(cash);

                if (canScroll) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  );
                }
              },
              onCloseDayCashCount: closeDayCashCount,
            )
          ],
        ),
      ),
    );
  }
}

class _BottomMenu extends StatefulWidget {
  const _BottomMenu(
      {required this.onNewCashAdded, required this.onCloseDayCashCount});

  final Function(Cash) onNewCashAdded;
  final void Function() onCloseDayCashCount;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FilledButton.tonal(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmationDialog(
                          description:
                              '¿Estás seguro de que quieres finalizar el arqueo?',
                          onAccept: () {
                            widget.onCloseDayCashCount();
                          },
                        ),
                      );
                    },
                    child: const Icon(Icons.save),
                  ),
                  const SizedBox(width: 5),
                  FilledButton.tonalIcon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmationDialog(
                          description:
                              '¿Estás seguro de que quieres limpiar la lista?',
                          onAccept: () {
                            context.read<CashListProvider>().cleanCashList();
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.replay_outlined),
                    label: const Text('Limpiar lista'),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              FilledButton.tonalIcon(
                onPressed: addNewCash,
                label: const Text('Agregar'),
                icon: const Icon(Icons.add),
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

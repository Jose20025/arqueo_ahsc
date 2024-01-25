import 'package:arqueo_ahsc/app/helpers/build_error_snack_bar.dart';
import 'package:arqueo_ahsc/app/providers/cash_list_provider.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:arqueo_ahsc/app/widgets/public/ahsc_logo.dart';
import 'package:arqueo_ahsc/app/widgets/buttons/cancel_button.dart';
import 'package:arqueo_ahsc/app/widgets/drawer/custom_drawer.dart';
import 'package:arqueo_ahsc/app/widgets/dayCashCounts/day_cash_counts_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // Cargamos los arqueos
    context.read<DayCashCountsProvider>().loadDayCashCounts();

    // Cargamos los ingresos
    context.read<IncomesProvider>().loadIncomes();

    // Cargamos los gastos
    context.read<ExpensesProvider>().loadExpenses();

    // Cargamos el cash list
    context.read<CashListProvider>().loadCashList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DayCashCountsProvider dayCashCountsProvider =
        context.read<DayCashCountsProvider>();

    return Scaffold(
      drawer: const CustomDrawer(page: ActivePage.home),

      //* AppBar
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Arqueos AHSC'),
            AHSCLogo(height: 60),
          ],
        ),
      ),

      //* Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (dayCashCountsProvider.dayCashCounts.isNotEmpty &&
              !dayCashCountsProvider.dayCashCounts.first.isClosed) {
            showErrorSnackBar(context,
                title:
                    'Debes cerrar el arqueo actual antes de agregar uno nuevo');

            return;
          }

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            builder: (BuildContext context) =>
                const _InitialCashCountAmountModal(),
          );
        },
        child: const Icon(Icons.add),
      ),

      //* Body
      body: const Column(
        children: [
          DayCashCounts(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _InitialCashCountAmountModal extends StatefulWidget {
  const _InitialCashCountAmountModal();

  @override
  State<_InitialCashCountAmountModal> createState() =>
      _InitialCashCountAmountModalState();
}

class _InitialCashCountAmountModalState
    extends State<_InitialCashCountAmountModal> {
  final TextEditingController _initialAmountController =
      TextEditingController();

  void createDayCashCount(BuildContext context) {
    if (_initialAmountController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Debes ingresar un monto inicial'),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
      return;
    }

    if (double.tryParse(_initialAmountController.text) == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Debes ingresar un monto válido'),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
      return;
    }

    // Leer el provider
    final DayCashCountsProvider dayCashCountsProvider =
        context.read<DayCashCountsProvider>();

    dayCashCountsProvider
        .createDayCashCount(double.parse(_initialAmountController.text));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Ingresa el monto inicial',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _initialAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                labelText: 'Monto inicial',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const CancelButton(),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: () => createDayCashCount(context),
                    child: const Text('Aceptar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

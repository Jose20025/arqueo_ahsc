import 'package:arqueo_ahsc/app/models/income.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:arqueo_ahsc/app/widgets/drawer/custom_drawer.dart';
import 'package:arqueo_ahsc/app/widgets/income/income_card_tile.dart';
import 'package:arqueo_ahsc/app/widgets/income/add_income_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomesPage extends StatefulWidget {
  const IncomesPage({super.key});

  @override
  State<IncomesPage> createState() => _IncomesPageState();
}

class _IncomesPageState extends State<IncomesPage> {
  @override
  void dispose() {
    // Guardamos los arqueos
    context.read<DayCashCountsProvider>().saveDayCashCounts();

    // Guardamos los ingresos
    context.read<IncomesProvider>().saveIncomes();

    // Guardamos los gastos
    context.read<ExpensesProvider>().saveExpenses();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Drawer
      drawer: const CustomDrawer(page: ActivePage.incomes),

      // AppBar
      appBar: AppBar(
        title: const Text('Ingresos'),
        centerTitle: true,
      ),

      // Body
      body: const _IncomesList(),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddIncomeModal(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _IncomesList extends StatelessWidget {
  const _IncomesList();

  @override
  Widget build(BuildContext context) {
    final List<Income> incomes = context.watch<IncomesProvider>().incomes;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: incomes.isEmpty
          ? const Center(
              child: Text(
                'No hay ingresos todavía\nTrata de agregar uno',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: incomes.length,
              itemBuilder: (context, index) {
                final Income income = incomes[index];

                return IncomeCardTile(income);
              },
            ),
    );
  }
}

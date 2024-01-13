import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:arqueo_ahsc/app/widgets/drawer/custom_drawer.dart';
import 'package:arqueo_ahsc/app/widgets/expense/add_expense_modal.dart';
import 'package:arqueo_ahsc/app/widgets/expense/expense_card_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
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
      drawer: const CustomDrawer(page: ActivePage.expenses),

      // AppBar
      appBar: AppBar(
        title: const Text('Gastos'),
        centerTitle: true,
      ),

      //Body
      body: const _ExpensesList(),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            isScrollControlled: true,
            builder: (context) => const AddExpenseModal(),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ExpensesList extends StatelessWidget {
  const _ExpensesList();

  @override
  Widget build(BuildContext context) {
    final expenses = context.watch<ExpensesProvider>().expenses;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: expenses.isEmpty
          ? const Center(
              child: Text(
                'No hay gastos todavía\nTrata de agregar uno',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];

                return ExpenseCardTile(expense);
              },
            ),
    );
  }
}

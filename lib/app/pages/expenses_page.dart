import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/widgets/drawer/custom_drawer.dart';
import 'package:arqueo_ahsc/app/widgets/expense/add_expense_modal.dart';
import 'package:arqueo_ahsc/app/widgets/expense/expense_card_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

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
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];

          return ExpenseCardTile(expense);
        },
      ),
    );
  }
}

import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/widgets/buttons/clean_list_button.dart';
import 'package:arqueo_ahsc/app/widgets/drawer/custom_drawer.dart';
import 'package:arqueo_ahsc/app/widgets/expense/add_expense_modal.dart';
import 'package:arqueo_ahsc/app/widgets/expense/expense_card_tile.dart';
import 'package:arqueo_ahsc/app/widgets/public/confirmation_dialog.dart';
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

        // Actions
        actions: [
          CleanListButton(
            onPressed: () {
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => ConfirmationDialog(
                  onAccept: () {
                    context.read<ExpensesProvider>().cleanExpenses();
                  },
                  description: '¿Deseas eliminar todos los gastos?',
                  color: Colors.red,
                ),
              );
            },
            color: Colors.red,
            iconColor: Colors.white,
          ),
          const SizedBox(width: 10),
        ],
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

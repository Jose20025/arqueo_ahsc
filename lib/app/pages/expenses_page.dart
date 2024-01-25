import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/widgets/buttons/clean_list_button.dart';
import 'package:arqueo_ahsc/app/widgets/drawer/custom_drawer.dart';
import 'package:arqueo_ahsc/app/widgets/expense/add_expense_modal.dart';
import 'package:arqueo_ahsc/app/widgets/expense/expense_card_tile.dart';
import 'package:arqueo_ahsc/app/widgets/public/bottom_total_container.dart';
import 'package:arqueo_ahsc/app/widgets/public/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final ScrollController _scrollController = ScrollController();

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
      body: Column(
        children: [
          _ExpensesList(scrollController: _scrollController),
          BottomTotalContainer(
            value: context.watch<ExpensesProvider>().total,
            color: Colors.red,
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showAddExpenseModal(context);

          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ExpensesList extends StatelessWidget {
  const _ExpensesList({this.scrollController});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final expenses = context.watch<ExpensesProvider>().expenses;

    return Expanded(
      child: Padding(
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
                controller: scrollController,
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];

                  return ExpenseCardTile(expense);
                },
              ),
      ),
    );
  }
}

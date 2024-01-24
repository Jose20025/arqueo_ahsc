import 'package:arqueo_ahsc/app/models/income.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:arqueo_ahsc/app/widgets/buttons/clean_list_button.dart';
import 'package:arqueo_ahsc/app/widgets/drawer/custom_drawer.dart';
import 'package:arqueo_ahsc/app/widgets/income/income_card_tile.dart';
import 'package:arqueo_ahsc/app/widgets/income/add_income_modal.dart';
import 'package:arqueo_ahsc/app/widgets/public/bottom_total_container.dart';
import 'package:arqueo_ahsc/app/widgets/public/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomesPage extends StatelessWidget {
  const IncomesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Drawer
      drawer: const CustomDrawer(page: ActivePage.incomes),

      // AppBar
      appBar: AppBar(
        title: const Text('Ingresos'),
        centerTitle: true,

        // Actions
        actions: [
          CleanListButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ConfirmationDialog(
                  onAccept: () {
                    context.read<IncomesProvider>().cleanIncomes();
                  },
                  description: '¿Deseas eliminar todos los ingresos?',
                  color: Colors.blue,
                ),
              );
            },
            color: Colors.blue,
            iconColor: Colors.white,
          ),
          const SizedBox(width: 10),
        ],
      ),

      // Body
      body: Column(
        children: [
          const _IncomesList(),
          BottomTotalContainer(
            value: context.watch<IncomesProvider>().total,
            color: Colors.blue,
          ),
        ],
      ),

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

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
      ),
    );
  }
}

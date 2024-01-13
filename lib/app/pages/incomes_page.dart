import 'package:arqueo_ahsc/app/models/income.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:arqueo_ahsc/app/widgets/drawer/custom_drawer.dart';
import 'package:arqueo_ahsc/app/widgets/income/custom_income_tile.dart';
import 'package:arqueo_ahsc/app/widgets/income/add_income_modal.dart';
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
      ),

      // Body
      body: const _IncomesList(),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            builder: (context) => const AddIncomeModal(),
          );
        },
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
      child: ListView.builder(
        itemCount: incomes.length,
        itemBuilder: (context, index) {
          final Income income = incomes[index];

          return CustomIncomeTile(income);
        },
      ),
    );
  }
}

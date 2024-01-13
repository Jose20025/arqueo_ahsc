import 'package:arqueo_ahsc/app/models/income.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:arqueo_ahsc/app/widgets/buttons/accept_button.dart';
import 'package:arqueo_ahsc/app/widgets/buttons/cancel_button.dart';
import 'package:arqueo_ahsc/app/widgets/drawer/custom_drawer.dart';
import 'package:arqueo_ahsc/app/widgets/income/custom_income_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class IncomesPage extends StatelessWidget {
  const IncomesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Drawer
      drawer: const CustomDrawer(page: Active.incomes),

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
            builder: (context) => const _AddIncomeModal(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _AddIncomeModal extends StatelessWidget {
  const _AddIncomeModal();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Agregar ingreso',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _AddIncomeForm(),
          ],
        ),
      ),
    );
  }
}

class _AddIncomeForm extends StatefulWidget {
  const _AddIncomeForm();

  @override
  State<_AddIncomeForm> createState() => __AddIncomeFormState();
}

class __AddIncomeFormState extends State<_AddIncomeForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _AmountFormField(controller: _amountController),
          const SizedBox(height: 15),
          _DescriptionFormField(controller: _descriptionController),
          const SizedBox(height: 15),
          Row(
            children: [
              const CancelButton(),
              const SizedBox(width: 8),
              AcceptButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  final IncomesProvider incomesProvider =
                      context.read<IncomesProvider>();

                  incomesProvider.addIncome(
                    Income(
                      id: const Uuid().v4(),
                      amount: double.parse(_amountController.text),
                      description: _descriptionController.text,
                    ),
                  );

                  Navigator.pop(context);
                },
                text: 'Agregar',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DescriptionFormField extends StatelessWidget {
  const _DescriptionFormField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Descripción',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        icon: Icon(Icons.description),
      ),
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
    );
  }
}

class _AmountFormField extends StatelessWidget {
  const _AmountFormField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Monto',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        icon: Icon(Icons.attach_money),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Debes ingresar un monto';
        }

        if (double.tryParse(value) == null) {
          return 'Debes ingresar un monto válido';
        }

        return null;
      },
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

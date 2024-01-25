import 'package:arqueo_ahsc/app/models/expense.dart';
import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/widgets/buttons/accept_button.dart';
import 'package:arqueo_ahsc/app/widgets/buttons/cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

Future<void> showAddExpenseModal(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    builder: (context) => const AddExpenseModal(),
  );
}

class AddExpenseModal extends StatelessWidget {
  const AddExpenseModal({super.key});

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
              'Agregar gasto',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _AddExpenseForm(),
          ],
        ),
      ),
    );
  }
}

class _AddExpenseForm extends StatefulWidget {
  const _AddExpenseForm();

  @override
  State<_AddExpenseForm> createState() => __AddExpenseFormState();
}

class __AddExpenseFormState extends State<_AddExpenseForm> {
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _AmountFormField(controller: amountController),
          const SizedBox(height: 15),
          _DescriptionFormField(controller: descriptionController),
          const SizedBox(height: 15),
          Row(
            children: [
              const CancelButton(),
              const SizedBox(width: 10),
              AcceptButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  final expensesProvider = context.read<ExpensesProvider>();

                  expensesProvider.addExpense(
                    Expense(
                      id: const Uuid().v4(),
                      description: descriptionController.text,
                      amount: double.parse(amountController.text),
                    ),
                  );

                  Navigator.of(context).pop();
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
  const _DescriptionFormField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        labelText: 'Descripción',
        icon: Icon(Icons.description),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese una descripción';
        }

        return null;
      },
    );
  }
}

class _AmountFormField extends StatelessWidget {
  const _AmountFormField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Monto',
        icon: Icon(Icons.attach_money),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un monto';
        }

        if (double.tryParse(value) == null) {
          return 'Ingrese un monto válido';
        }

        return null;
      },
    );
  }
}

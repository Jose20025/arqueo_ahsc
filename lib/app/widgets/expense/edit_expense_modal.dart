import 'package:arqueo_ahsc/app/models/expense.dart';
import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/widgets/buttons/accept_button.dart';
import 'package:arqueo_ahsc/app/widgets/buttons/cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showEditExpenseModal(BuildContext context, Expense expense) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    builder: (context) => EditExpenseModal(expense),
  );
}

class EditExpenseModal extends StatelessWidget {
  const EditExpenseModal(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Editar gasto',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _EditExpenseForm(expense),
          ],
        ),
      ),
    );
  }
}

class _EditExpenseForm extends StatefulWidget {
  const _EditExpenseForm(this.expense);

  final Expense expense;

  @override
  State<_EditExpenseForm> createState() => __EditExpenseFormState();
}

class __EditExpenseFormState extends State<_EditExpenseForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController descriptionController;
  late final TextEditingController amountController;

  @override
  void initState() {
    descriptionController =
        TextEditingController(text: widget.expense.description);
    amountController =
        TextEditingController(text: widget.expense.amount.toString());

    super.initState();
  }

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
              const Spacer(),
              AcceptButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  final expensesProvider = context.read<ExpensesProvider>();

                  expensesProvider.editExpense(
                    widget.expense.id,
                    Expense(
                      id: widget.expense.id,
                      description: descriptionController.text,
                      amount: double.parse(amountController.text),
                    ),
                  );

                  Navigator.of(context).pop();
                },
                text: 'Aceptar',
              )
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

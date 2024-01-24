import 'package:arqueo_ahsc/app/models/income.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:arqueo_ahsc/app/widgets/buttons/accept_button.dart';
import 'package:arqueo_ahsc/app/widgets/buttons/cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showEditIncomeModal(BuildContext context, Income income) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    builder: (context) => EditIncomeModal(income: income),
  );
}

class EditIncomeModal extends StatelessWidget {
  const EditIncomeModal({required this.income, super.key});

  final Income income;

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
              'Editar ingreso',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _EditIncomeForm(income),
          ],
        ),
      ),
    );
  }
}

class _EditIncomeForm extends StatefulWidget {
  const _EditIncomeForm(this.income);

  final Income income;

  @override
  State<_EditIncomeForm> createState() => __EditIncomeFormState();
}

class __EditIncomeFormState extends State<_EditIncomeForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController amountController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    amountController =
        TextEditingController(text: widget.income.amount.toString());
    descriptionController =
        TextEditingController(text: widget.income.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _EditAmountField(amountController: amountController),
          const SizedBox(height: 15),
          _EditDescriptionField(descriptionController: descriptionController),
          const SizedBox(height: 15),
          Row(
            children: [
              const CancelButton(),
              const SizedBox(width: 8),
              AcceptButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  final IncomesProvider incomesProvider =
                      context.read<IncomesProvider>();

                  incomesProvider.updateIncome(
                    widget.income.id,
                    Income(
                      id: widget.income.id,
                      amount: double.parse(amountController.text),
                      description: descriptionController.text.isNotEmpty
                          ? descriptionController.text
                          : null,
                    ),
                  );

                  Navigator.pop(context);
                },
                text: 'Editar',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EditDescriptionField extends StatelessWidget {
  const _EditDescriptionField({
    required this.descriptionController,
  });

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: descriptionController,
      decoration: const InputDecoration(
        labelText: 'Descripción',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _EditAmountField extends StatelessWidget {
  const _EditAmountField({
    required this.amountController,
  });

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Monto',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'El monto es requerido';
        }

        if (double.tryParse(value) == null) {
          return 'El monto debe ser un número';
        }

        return null;
      },
    );
  }
}

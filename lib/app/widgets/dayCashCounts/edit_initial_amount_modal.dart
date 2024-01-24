import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
import 'package:arqueo_ahsc/app/widgets/buttons/accept_button.dart';
import 'package:arqueo_ahsc/app/widgets/buttons/cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showEditInitialAmountModal(
    BuildContext context, DayCashCount dayCashCount) {
  Navigator.pop(context);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    builder: (_) => EditInitialAmountModal(dayCashCount),
  );
}

class EditInitialAmountModal extends StatelessWidget {
  const EditInitialAmountModal(this.dayCashCount, {super.key});

  final DayCashCount dayCashCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Editar monto inicial',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _EditInitialAmountForm(dayCashCount),
          ],
        ),
      ),
    );
  }
}

class _EditInitialAmountForm extends StatefulWidget {
  const _EditInitialAmountForm(this.dayCashCount);

  final DayCashCount dayCashCount;

  @override
  State<_EditInitialAmountForm> createState() => __EditInitialAmountFormState();
}

class __EditInitialAmountFormState extends State<_EditInitialAmountForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _initialAmountController;

  @override
  void initState() {
    _initialAmountController = TextEditingController(
        text: widget.dayCashCount.initialAmount.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _initialAmountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              hintText: 'Monto inicial',
              icon: Icon(Icons.attach_money),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa un monto';
              }

              if (double.tryParse(value) == null) {
                return 'Ingresa un monto válido';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const CancelButton(),
              const SizedBox(width: 10),
              AcceptButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  final DayCashCountsProvider dayCashCountsProvider =
                      context.read<DayCashCountsProvider>();

                  dayCashCountsProvider.updateDayCashCountInitialAmount(
                    widget.dayCashCount.id,
                    double.parse(_initialAmountController.text),
                  );

                  Navigator.pop(context);
                },
                text: 'Aceptar',
              )
            ],
          )
        ],
      ),
    );
  }
}

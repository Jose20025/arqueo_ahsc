import 'package:arqueo_ahsc/app/config/theme.dart';
import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
import 'package:arqueo_ahsc/app/widgets/public/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteCashCountButton extends StatelessWidget {
  DeleteCashCountButton(this.dayCashCount, {super.key});

  final DayCashCount dayCashCount;

  final buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(ThemeConfig.secondaryColor),
    iconColor: const MaterialStatePropertyAll(Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: buttonStyle,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            onAccept: () {
              context
                  .read<DayCashCountsProvider>()
                  .deleteDayCashCount(dayCashCount.id);
            },
            description: '¿Estás seguro de que quieres eliminar este arqueo?',
          ),
        );
      },
      icon: const Icon(Icons.delete),
    );
  }
}

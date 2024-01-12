import 'package:arqueo_ahsc/app/helpers/build_error_snack_bar.dart';
import 'package:arqueo_ahsc/app/pages/add_cash_count_page.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
import 'package:arqueo_ahsc/app/widgets/ahsc_logo.dart';
import 'package:arqueo_ahsc/app/widgets/day_cash_counts_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final DayCashCountsProvider dayCashCountsProvider =
        context.read<DayCashCountsProvider>();

    return Scaffold(
        //* AppBar
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Arqueos AHSC'),
              AHSCLogo(height: 60),
            ],
          ),
        ),

        //* Floating Action Button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (dayCashCountsProvider.dayCashCounts.isNotEmpty &&
                !dayCashCountsProvider.dayCashCounts.first.isClosed) {
              showErrorSnackBar(context,
                  title:
                      'Debes cerrar el arqueo actual antes de agregar uno nuevo');

              return;
            }

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AddCashCountPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),

        //* Body
        body: const Column(
          children: [
            DayCashCounts(),
            SizedBox(height: 20),
          ],
        ));
  }
}

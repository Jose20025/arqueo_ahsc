import 'package:arqueo_ahsc/app/pages/add_cash_count_page.dart';
import 'package:arqueo_ahsc/app/widgets/ahsc_logo.dart';
import 'package:arqueo_ahsc/app/widgets/day_cash_counts_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddCashCountPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      //* Body
      body: const DayCashCounts(),
    );
  }
}

import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
import 'package:arqueo_ahsc/app/widgets/day_cash_count_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayCashCounts extends StatelessWidget {
  const DayCashCounts({super.key});

  @override
  Widget build(BuildContext context) {
    final dayCashCountList =
        context.watch<DayCashCountsProvider>().dayCashCounts;

    return dayCashCountList.isEmpty
        ? const _NoDayCashCounts()
        : DayCashCountsList(dayCashCountList);
  }
}

class DayCashCountsList extends StatelessWidget {
  const DayCashCountsList(this.dayCashCountList, {super.key});

  final List<DayCashCount> dayCashCountList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (_, index) => DayCashCountCard(dayCashCountList[index]),
        itemCount: dayCashCountList.length,
      ),
    );
  }
}

class _NoDayCashCounts extends StatelessWidget {
  const _NoDayCashCounts();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: const Center(
          child: Text(
            'No hay arqueos de caja\nAgrega uno para empezar',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

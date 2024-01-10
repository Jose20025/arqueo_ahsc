import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
import 'package:arqueo_ahsc/app/widgets/day_cash_count_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayCashCounts extends StatelessWidget {
  const DayCashCounts({super.key});

  @override
  Widget build(BuildContext context) {
    List<DayCashCount> dayCashCountList =
        context.read<DayCashCountsProvider>().dayCashCounts;

    return dayCashCountList.isEmpty
        ? const _NoDayCashCounts()
        : DayCashCountsList(dayCashCountList: dayCashCountList);
  }
}

class DayCashCountsList extends StatelessWidget {
  const DayCashCountsList({
    super.key,
    required this.dayCashCountList,
  });

  final List<DayCashCount> dayCashCountList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      itemBuilder: (_, index) => DayCashCountCard(dayCashCountList[index]),
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemCount: dayCashCountList.length,
    ));
  }
}

class _NoDayCashCounts extends StatelessWidget {
  const _NoDayCashCounts();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No hay arqueos'),
    );
  }
}

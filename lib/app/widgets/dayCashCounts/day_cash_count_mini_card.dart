import 'package:arqueo_ahsc/app/config/theme.dart';
import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayCashCountMiniCard extends StatelessWidget {
  const DayCashCountMiniCard(this.dayCashCount, {super.key});

  final DayCashCount dayCashCount;

  String buildFace() {
    if (dayCashCount.isExpectedAmountOk) return '😎';

    if (dayCashCount.isMoneyMissing) return '💀';

    return '🤑';
  }

  String buildDescription() {
    if (dayCashCount.isExpectedAmountOk) return 'Cuadró la caja';

    if (dayCashCount.isMoneyMissing) {
      return 'Faltó plata:  ${NumberFormat.currency().format(dayCashCount.difference)}';
    }

    return 'Sobró plata:  ${NumberFormat.currency().format(dayCashCount.difference)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: ThemeConfig.secondaryColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Fecha:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        DateFormat.yMMMEd().format(dayCashCount.date),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        buildFace(),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        buildDescription(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(dayCashCount),
                    ),
                  );
                },
                icon: const Icon(Icons.list_alt_rounded),
              )
            ],
          ),
        ),
      ),
    );
  }
}

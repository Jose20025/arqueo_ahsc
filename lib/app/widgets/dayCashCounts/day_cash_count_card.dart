import 'package:arqueo_ahsc/app/models/day_cash_count.dart';
import 'package:arqueo_ahsc/app/pages/details_page.dart';
import 'package:arqueo_ahsc/app/widgets/dayCashCounts/close_cash_count_button.dart';
import 'package:arqueo_ahsc/app/widgets/dayCashCounts/delete_cash_count_button.dart';
import 'package:arqueo_ahsc/app/widgets/dayCashCounts/details_button.dart';
import 'package:arqueo_ahsc/app/widgets/dayCashCounts/edit_cash_count_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayCashCountCard extends StatelessWidget {
  const DayCashCountCard(
    this.dayCashCount, {
    super.key,
  });

  final DayCashCount dayCashCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: Colors.green,
                width: 2,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(
                bottom: 10,
                right: 15,
                left: 15,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(
                      Icons.attach_money_rounded,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Arqueo de caja',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.stop_circle_sharp,
                      color: dayCashCount.isClosed ? Colors.red : Colors.green,
                      size: 30,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.attach_money,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Monto Inicial',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green,
                      ),
                      child: Text(
                        NumberFormat.currency()
                            .format(dayCashCount.initialAmount),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.date_range,
                      color: Colors.blue,
                    ),
                    title: const Text(
                      'Fecha',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      child: Text(
                        DateFormat.yMMMEd().format(dayCashCount.date),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  DetailsButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(dayCashCount),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          DeleteCashCountButton(dayCashCount),
                          const SizedBox(width: 5),
                          EditCashCountButton(dayCashCount),
                        ],
                      ),
                      CloseCashCountButton(dayCashCount),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

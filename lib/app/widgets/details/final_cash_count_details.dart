import 'package:arqueo_ahsc/app/models/cash_count.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinalCashCountDetails extends StatelessWidget {
  const FinalCashCountDetails(this.cashCount, {super.key});

  final CashCount cashCount;

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(fontSize: 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Desglose del Arqueo Final',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          surfaceTintColor: Colors.white,
          child: Column(
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tipo',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Cantidad',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('Billetes de 200', style: style),
                trailing: Text(
                  cashCount.cash200 == 0
                      ? '0'
                      : NumberFormat.decimalPatternDigits()
                          .format(cashCount.cash200),
                  style: style,
                ),
              ),
              ListTile(
                title: Text('Billetes de 100', style: style),
                trailing: Text(
                  cashCount.cash100 == 0
                      ? '0'
                      : NumberFormat.decimalPatternDigits()
                          .format(cashCount.cash100),
                  style: style,
                ),
              ),
              ListTile(
                title: Text('Billetes de 50', style: style),
                trailing: Text(
                  cashCount.cash50 == 0
                      ? '0'
                      : NumberFormat.decimalPatternDigits()
                          .format(cashCount.cash50),
                  style: style,
                ),
              ),
              ListTile(
                title: Text('Billetes de 20', style: style),
                trailing: Text(
                  cashCount.cash20 == 0
                      ? '0'
                      : NumberFormat.decimalPatternDigits()
                          .format(cashCount.cash20),
                  style: style,
                ),
              ),
              ListTile(
                title: Text('Billetes de 10', style: style),
                trailing: Text(
                  cashCount.cash10 == 0
                      ? '0'
                      : NumberFormat.decimalPatternDigits()
                          .format(cashCount.cash10),
                  style: style,
                ),
              ),
              ListTile(
                title: Text('Monedas de 5', style: style),
                trailing: Text(
                  cashCount.coin5 == 0
                      ? '0'
                      : NumberFormat.decimalPatternDigits()
                          .format(cashCount.coin5),
                  style: style,
                ),
              ),
              ListTile(
                title: Text('Monedas de 2', style: style),
                trailing: Text(
                  cashCount.coin2 == 0
                      ? '0'
                      : NumberFormat.decimalPatternDigits()
                          .format(cashCount.coin2),
                  style: style,
                ),
              ),
              ListTile(
                title: Text('Monedas de 1', style: style),
                trailing: Text(
                  cashCount.coin1 == 0
                      ? '0'
                      : NumberFormat.decimalPatternDigits()
                          .format(cashCount.coin1),
                  style: style,
                ),
              ),
              ListTile(
                title: Text('Monedas de 0.50', style: style),
                trailing: Text(
                  cashCount.coin05 == 0
                      ? '0'
                      : NumberFormat.decimalPatternDigits()
                          .format(cashCount.coin05),
                  style: style,
                ),
              ),
              ListTile(
                title: Text('Monto bruto', style: style),
                trailing: Text(
                  NumberFormat.currency().format(cashCount.bruteCash),
                  style: style,
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.attach_money, color: Colors.green),
                title: const Text('Total'),
                trailing: Text(
                  NumberFormat.currency().format(cashCount.totalAmount),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}

import 'package:arqueo_ahsc/app/models/cash_count.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinalCashCountDetails extends StatelessWidget {
  const FinalCashCountDetails(this.cashCount, {super.key});

  final CashCount cashCount;

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Desglose del Arqueo Final',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: Colors.green,
              width: 1,
            ),
          ),
          surfaceTintColor: Colors.white,
          shadowColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tipo',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Total',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ListTile(
                  title: Text('Billetes de 200', style: style),
                  subtitle: Text(
                      'Cantidad: ${cashCount.cash200 == 0 ? '0' : NumberFormat.decimalPatternDigits().format(cashCount.cash200)}'),
                  trailing: Text(
                    NumberFormat.currency().format(
                        cashCount.cash200 == 0 ? 0 : cashCount.cash200! * 200),
                    style: style,
                  ),
                ),
                ListTile(
                  title: Text('Billetes de 100', style: style),
                  subtitle: Text(
                      'Cantidad: ${cashCount.cash100 == 0 ? '0' : NumberFormat.decimalPatternDigits().format(cashCount.cash100)}'),
                  trailing: Text(
                    NumberFormat.currency().format(
                        cashCount.cash100 == 0 ? 0 : cashCount.cash100! * 100),
                    style: style,
                  ),
                ),
                ListTile(
                  title: Text('Billetes de 50', style: style),
                  subtitle: Text(
                      'Cantidad: ${cashCount.cash50 == 0 ? '0' : NumberFormat.decimalPatternDigits().format(cashCount.cash50)}'),
                  trailing: Text(
                    NumberFormat.currency().format(
                        cashCount.cash50 == 0 ? 0 : cashCount.cash50! * 50),
                    style: style,
                  ),
                ),
                ListTile(
                  title: Text('Billetes de 20', style: style),
                  subtitle: Text(
                      'Cantidad: ${cashCount.cash20 == 0 ? '0' : NumberFormat.decimalPatternDigits().format(cashCount.cash20)}'),
                  trailing: Text(
                    NumberFormat.currency().format(
                        cashCount.cash20 == 0 ? 0 : cashCount.cash20! * 20),
                    style: style,
                  ),
                ),
                ListTile(
                  title: Text('Billetes de 10', style: style),
                  subtitle: Text(
                      'Cantidad: ${cashCount.cash10 == 0 ? '0' : NumberFormat.decimalPatternDigits().format(cashCount.cash10)}'),
                  trailing: Text(
                    NumberFormat.currency().format(
                        cashCount.cash10 == 0 ? 0 : cashCount.cash10! * 10),
                    style: style,
                  ),
                ),
                ListTile(
                  title: Text('Monedas de 5', style: style),
                  subtitle: Text(
                      'Cantidad: ${cashCount.coin5 == 0 ? '0' : NumberFormat.decimalPatternDigits().format(cashCount.coin5)}'),
                  trailing: Text(
                    NumberFormat.currency().format(
                        cashCount.coin5 == 0 ? 0 : cashCount.coin5! * 5),
                    style: style,
                  ),
                ),
                ListTile(
                  title: Text('Monedas de 2', style: style),
                  subtitle: Text(
                      'Cantidad: ${cashCount.coin2 == 0 ? '0' : NumberFormat.decimalPatternDigits().format(cashCount.coin2)}'),
                  trailing: Text(
                    NumberFormat.currency().format(
                        cashCount.coin2 == 0 ? 0 : cashCount.coin2! * 2),
                    style: style,
                  ),
                ),
                ListTile(
                  title: Text('Monedas de 1', style: style),
                  subtitle: Text(
                      'Cantidad: ${cashCount.coin1 == 0 ? '0' : NumberFormat.decimalPatternDigits().format(cashCount.coin1)}'),
                  trailing: Text(
                    NumberFormat.currency().format(
                        cashCount.coin1 == 0 ? 0 : cashCount.coin1! * 1),
                    style: style,
                  ),
                ),
                ListTile(
                  title: Text('Monedas de 0.50', style: style),
                  subtitle: Text(
                    'Cantidad: ${cashCount.coin05 == 0 ? '0' : NumberFormat.decimalPatternDigits().format(cashCount.coin05)}',
                  ),
                  trailing: Text(
                    NumberFormat.currency().format(
                        cashCount.coin05 == 0 ? 0 : cashCount.coin05! * 0.5),
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green.withOpacity(0.8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    leading:
                        const Icon(Icons.attach_money, color: Colors.white),
                    title: const Text(
                      'Total',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    trailing: Text(
                      NumberFormat.currency().format(cashCount.totalAmount),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}

import 'package:arqueo_ahsc/app/models/cash.dart';

Map<String, dynamic> calculateAmountsMap(List<Cash> cashList) {
  final Map<String, dynamic> amountsMap = {};
  double total = 0;

  for (Cash cash in cashList) {
    switch (cash.name) {
      case 'Billetes de 200':
        if (amountsMap.containsKey('cash200')) {
          amountsMap['cash200'] += cash.amount;
        } else {
          amountsMap['cash200'] = cash.amount;
        }

        total += cash.total;
        break;

      case 'Billetes de 100':
        if (amountsMap.containsKey('cash100')) {
          amountsMap['cash100'] += cash.amount;
        } else {
          amountsMap['cash100'] = cash.amount;
        }

        total += cash.total;
        break;

      case 'Billetes de 50':
        if (amountsMap.containsKey('cash50')) {
          amountsMap['cash50'] += cash.amount;
        } else {
          amountsMap['cash50'] = cash.amount;
        }

        total += cash.total;
        break;

      case 'Billetes de 20':
        if (amountsMap.containsKey('cash20')) {
          amountsMap['cash20'] += cash.amount;
        } else {
          amountsMap['cash20'] = cash.amount;
        }

        total += cash.total;
        break;

      case 'Billetes de 10':
        if (amountsMap.containsKey('cash10')) {
          amountsMap['cash10'] += cash.amount;
        } else {
          amountsMap['cash10'] = cash.amount;
        }

        total += cash.total;
        break;

      case 'Monedas de 5':
        if (amountsMap.containsKey('coin5')) {
          amountsMap['coin5'] += cash.amount;
        } else {
          amountsMap['coin5'] = cash.amount;
        }

        total += cash.total;
        break;

      case 'Monedas de 2':
        if (amountsMap.containsKey('coin2')) {
          amountsMap['coin2'] += cash.amount;
        } else {
          amountsMap['coin2'] = cash.amount;
        }

        total += cash.total;
        break;

      case 'Monedas de 1':
        if (amountsMap.containsKey('coin1')) {
          amountsMap['coin1'] += cash.amount;
        } else {
          amountsMap['coin1'] = cash.amount;
        }

        total += cash.total;
        break;

      case 'Monedas de 0.5':
        if (amountsMap.containsKey('coin05')) {
          amountsMap['coin05'] += cash.amount;
        } else {
          amountsMap['coin05'] = cash.amount;
        }

        total += cash.total;
        break;

      case 'Monto bruto':
        if (amountsMap.containsKey('bruteCash')) {
          amountsMap['bruteCash'] += cash.total;
        } else {
          amountsMap['bruteCash'] = cash.total;
        }

        total += cash.total;
        break;
    }
  }

  amountsMap['total'] = total;

  return amountsMap;
}

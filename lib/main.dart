import 'package:arqueo_ahsc/app/app.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';

void initializeIntl() {
  Intl.defaultLocale = 'es_BO';
  initializeDateFormatting('es_BO', null);

  numberFormatSymbols['es_BO'] = const NumberSymbols(
    NAME: 'es_BO',
    DECIMAL_SEP: ',',
    GROUP_SEP: '.',
    PERCENT: '%',
    ZERO_DIGIT: '0',
    PLUS_SIGN: '+',
    MINUS_SIGN: '-',
    EXP_SYMBOL: 'E',
    PERMILL: '‰',
    INFINITY: '∞',
    NAN: 'NaN',
    DECIMAL_PATTERN: '#,##0.###',
    SCIENTIFIC_PATTERN: '#E0',
    PERCENT_PATTERN: '#,##0%',
    CURRENCY_PATTERN: '¤#,##0.00',
    DEF_CURRENCY_CODE: 'Bs ',
  );
}

void main() {
  initializeIntl();

  runApp(const App());
}

import 'package:arqueo_ahsc/app/config/theme.dart';
import 'package:arqueo_ahsc/app/pages/expenses_page.dart';
import 'package:arqueo_ahsc/app/pages/home_page.dart';
import 'package:arqueo_ahsc/app/pages/incomes_page.dart';
import 'package:arqueo_ahsc/app/providers/cash_list_provider.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
import 'package:arqueo_ahsc/app/providers/expenses_provider.dart';
import 'package:arqueo_ahsc/app/providers/incomes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Aquí van los providers
        ChangeNotifierProvider(create: (_) => DayCashCountsProvider()),
        ChangeNotifierProvider(create: (_) => IncomesProvider()),
        ChangeNotifierProvider(create: (_) => ExpensesProvider()),
        ChangeNotifierProvider(create: (_) => CashListProvider()),
      ],
      child: MaterialApp(
        title: 'Arqueo AHSC',
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.getTheme(),
        initialRoute: '/',
        routes: {
          '/': (_) => const HomePage(),
          '/incomes': (_) => const IncomesPage(),
          '/expenses': (_) => const ExpensesPage(),
        },
      ),
    );
  }
}

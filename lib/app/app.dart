import 'package:arqueo_ahsc/app/config/theme.dart';
import 'package:arqueo_ahsc/app/pages/home_page.dart';
import 'package:arqueo_ahsc/app/providers/day_cash_counts_provider.dart';
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
      ],
      child: MaterialApp(
        title: 'Arqueo AHSC',
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.getTheme(),
        home: const HomePage(),
      ),
    );
  }
}

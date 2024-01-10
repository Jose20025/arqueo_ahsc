import 'package:arqueo_ahsc/app/config/theme.dart';
import 'package:arqueo_ahsc/app/pages/home_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arqueo AHSC',
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.getTheme(),
      home: const HomePage(),
    );
  }
}

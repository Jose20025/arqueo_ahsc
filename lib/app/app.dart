import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Arqueo AHSC',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('Arqueo AHSC'),
        ),
      ),
    );
  }
}

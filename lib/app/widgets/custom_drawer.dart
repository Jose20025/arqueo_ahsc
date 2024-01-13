import 'package:arqueo_ahsc/app/config/theme.dart';
import 'package:arqueo_ahsc/app/widgets/ahsc_logo.dart';
import 'package:flutter/material.dart';

enum Active { home, incomes, expenses }

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.page});

  final Active page;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const DrawerHeader(
              child: AHSCLogo(height: 100),
            ),
            TextButton(
              onPressed: () {
                if (page == Active.home) return;

                Navigator.pushReplacementNamed(context, '/home');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  page == Active.home
                      ? ThemeConfig.secondaryColor.withOpacity(0.3)
                      : Colors.transparent,
                ),
              ),
              child: const ListTile(
                leading: Icon(Icons.home),
                title: Text('Inicio'),
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: () {
                if (page == Active.incomes) return;

                Navigator.pushReplacementNamed(context, '/incomes');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  page == Active.incomes
                      ? ThemeConfig.secondaryColor.withOpacity(0.3)
                      : Colors.transparent,
                ),
              ),
              child: const ListTile(
                leading: Icon(Icons.account_balance_wallet_outlined),
                title: Text('Ingresos'),
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: () {
                if (page == Active.expenses) return;

                Navigator.pushReplacementNamed(context, '/expenses');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  page == Active.expenses
                      ? ThemeConfig.secondaryColor.withOpacity(0.3)
                      : Colors.transparent,
                ),
              ),
              child: const ListTile(
                leading: Icon(Icons.account_balance_wallet_rounded),
                title: Text('Gastos'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

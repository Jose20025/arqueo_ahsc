import 'package:arqueo_ahsc/app/config/theme.dart';
import 'package:arqueo_ahsc/app/widgets/ahsc_logo.dart';
import 'package:flutter/material.dart';

enum Active { home, incomes, expenses }

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.page});

  final Active page;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const DrawerHeader(
                child: AHSCLogo(height: 100),
              ),
              _CustomDrawerNavButton(
                title: 'Inicio',
                icon: Icons.home,
                activePage: page,
                pageToCompare: Active.home,
                onPressed: () {
                  if (page == Active.home) return;

                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
              const SizedBox(height: 5),
              _CustomDrawerNavButton(
                title: 'Ingresos',
                icon: Icons.wallet,
                activePage: page,
                onPressed: () {
                  if (page == Active.incomes) return;

                  Navigator.pushReplacementNamed(context, '/incomes');
                },
                pageToCompare: Active.incomes,
              ),
              const SizedBox(height: 5),
              _CustomDrawerNavButton(
                title: 'Gastos',
                icon: Icons.account_balance_wallet_outlined,
                activePage: page,
                pageToCompare: Active.expenses,
                onPressed: () {
                  if (page == Active.expenses) return;

                  Navigator.pushReplacementNamed(context, '/expenses');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomDrawerNavButton extends StatelessWidget {
  const _CustomDrawerNavButton({
    required this.title,
    required this.icon,
    required this.activePage,
    required this.pageToCompare,
    required this.onPressed,
  });

  final Active activePage;
  final Active pageToCompare;
  final void Function() onPressed;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          activePage == pageToCompare
              ? ThemeConfig.secondaryColor.withOpacity(0.3)
              : Colors.transparent,
        ),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}

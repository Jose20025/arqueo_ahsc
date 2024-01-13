import 'package:arqueo_ahsc/app/config/theme.dart';
import 'package:arqueo_ahsc/app/widgets/public/ahsc_logo.dart';
import 'package:flutter/material.dart';

enum ActivePage { home, incomes, expenses }

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.page});

  final ActivePage page;

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
                pageToCompare: ActivePage.home,
                onPressed: () {
                  if (page == ActivePage.home) return;

                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
              const SizedBox(height: 5),
              _CustomDrawerNavButton(
                title: 'Ingresos',
                icon: Icons.wallet,
                activePage: page,
                pageToCompare: ActivePage.incomes,
                onPressed: () {
                  if (page == ActivePage.incomes) return;

                  Navigator.pushReplacementNamed(context, '/incomes');
                },
              ),
              const SizedBox(height: 5),
              _CustomDrawerNavButton(
                title: 'Gastos',
                icon: Icons.account_balance_wallet_outlined,
                activePage: page,
                pageToCompare: ActivePage.expenses,
                onPressed: () {
                  if (page == ActivePage.expenses) return;

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

  final ActivePage activePage;
  final ActivePage pageToCompare;
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

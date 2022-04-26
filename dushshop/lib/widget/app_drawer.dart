import 'package:dushshop/screens/orders_screen.dart';
import 'package:dushshop/screens/product_overview_screen.dart';
import 'package:flutter/material.dart';
import '../screens/product_overview_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: const Text(
            ' Options',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Shop'),
          onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Order'),
          onTap: () => Navigator.of(context)
              .pushReplacementNamed(OrdersScreen.routeName),
        ),
      ]),
    );
  }
}

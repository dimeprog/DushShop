import 'package:dushshop/screens/orders_screen.dart';
import 'package:dushshop/screens/product_overview_screen.dart';
import 'package:dushshop/screens/user_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_overview_screen.dart';
import '../provider/orders.dart';
import '../provider/auth.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final orderdata = Provider.of<Orders>(context, listen: false).order;
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
          leading: const Icon(
            Icons.shop,
            color: Colors.pinkAccent,
          ),
          title: const Text(
            'Shop',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 18),
          ),
          onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(
            Icons.payment,
            color: Colors.pinkAccent,
          ),
          title: const Text(
            'Order',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 18),
          ),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
          },
        ),
        const Divider(
            // thickness: 1,
            ),
        ListTile(
          leading: const Icon(
            Icons.edit,
            color: Colors.pinkAccent,
          ),
          title: const Text(
            'Manage product',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 18),
          ),
          onTap: () => Navigator.of(context)
              .pushReplacementNamed(UserProductScreen.routeName),
        ),
        const Divider(),
        ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.pinkAccent,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logOut();
            }),
      ]),
    );
  }
}

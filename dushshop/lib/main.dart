import '../provider/auth.dart';

import '../screens/auth_screen.dart';
import '../screens/edit_product_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/user_product_screen.dart';
import './provider/cart.dart';
import './provider/orders.dart';
import './screens/cart_screen.dart';
import './screens/product_overview_screen.dart';
import 'package:flutter/material.dart';
import './screens/product_detail_screen.dart';
import './provider/product_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            errorColor: Colors.redAccent,
            fontFamily: 'Lato',
            accentTextTheme: const TextTheme(
              titleMedium: TextStyle(
                color: Colors.lightBlue,
              ),
              bodyLarge: TextStyle(
                  color: Colors.black38,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            textTheme: const TextTheme(
              titleMedium: TextStyle(
                color: Colors.lightBlue,
              ),
              bodyLarge: TextStyle(
                  color: Colors.black38,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )),
        home: AuthScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}

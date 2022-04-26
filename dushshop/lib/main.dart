import 'package:dushshop/provider/cart.dart';
import './screens/cart_screen.dart';

import './screens/product_overview_screen.dart';
import 'package:flutter/material.dart';
import './screens/product_detail_screen.dart';
import './provider/product_provider.dart';
import 'package:provider/provider.dart';
import './provider/cart.dart';

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
          create: (ctx) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                color: Colors.black38,
                fontSize: 26,
              ),
            )),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}

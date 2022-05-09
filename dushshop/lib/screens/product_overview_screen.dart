import 'package:dushshop/screens/user_product_screen.dart';

import '../widget/app_drawer.dart';

import '../provider/cart.dart';
import '../provider/product_provider.dart';
import '../screens/cart_screen.dart';
import '../widget/badge.dart';
import '../widget/product_grid.dart';
import '../widget/product_item.dart';
import 'package:flutter/material.dart';
import '../provider/product.dart';
import 'package:provider/provider.dart';

enum FilterOption { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavoriteOnly = false;
  var initSetValue = true;
  var isloading = false;

  // @override
  // void initState() {
  //   // this works because i set listen to false
  //   Provider.of<ProductProvider>(context, listen: false).fetchAndSetData();
  //   // using future duration
  //   // Future.delayed(Duration.zero).then((_) {
  //   //   Provider.of<ProductProvider>(context).fetchAndSetData();
  //   // });
  //   super.initState();
  // }

  void _showDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('An error occured'),
              content: Text(message),
              actions: [
                FlatButton(
                  child: Text('okay'),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ],
            ));
  }

  //  most used case
  @override
  void didChangeDependencies() {
    if (initSetValue) {
      setState(() {
        isloading = true;
      });
      Provider.of<ProductProvider>(context, listen: false)
          .fetchAndSetData()
          .then((_) {
        isloading = false;
      });
    }
    initSetValue = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ProductData = Provider.of<ProductProvider>(context).item;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DushShop',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.Favorites) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                onTap: () {},
                child: const Text(
                  'Show favorite',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: FilterOption.Favorites,
              ),
              PopupMenuItem(
                child: const Text(
                  'Show All',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {},
                value: FilterOption.All,
              )
            ],
          ),
          Consumer<Cart>(
            builder: (_, Cart, _2) => Badge(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: Icon(Icons.shopping_cart),
              ),
              value: Cart.itemCount.toString(),
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(_showFavoriteOnly),
    );
  }
}

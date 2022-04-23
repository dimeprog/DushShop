import 'package:dushshop/provider/product_provider.dart';
import 'package:dushshop/widget/product_grid.dart';

import '../widget/product_item.dart';
import 'package:flutter/material.dart';
import '../provider/product.dart';
import 'package:provider/provider.dart';

enum FilterOption { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavoriteOnly = false;
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
                  ])
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}

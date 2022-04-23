import 'package:dushshop/provider/product_provider.dart';

import '../widget/product_item.dart';
import 'package:flutter/material.dart';
import '../provider/product.dart';
import 'package:provider/provider.dart';

class ProductOverviewScreen extends StatelessWidget {
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
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) => ChangeNotifierProvider(
          create: (context) => ProductData[index],
          child: ProductItem(
              // id: ProductData[index].id,
              // imageUrl: ProductData[index].imageUrl,
              // title: loadedProduct[index].title,
              ),
        ),
        itemCount: ProductData.length,
      ),
    );
  }
}

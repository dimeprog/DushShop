import 'package:flutter/material.dart';
import '../provider/product_provider.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavourite;
  ProductGrid(this.showFavourite);
  @override
  Widget build(BuildContext context) {
    final ProductData = Provider.of<ProductProvider>(context);
    final product =
        showFavourite ? ProductData.favoriteItems : ProductData.item;
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: product[index],
        child: ProductItem(
            // id: product[index].id,
            // imageUrl: product[index].imageUrl,
            // title: product[index].title,
            ),
      ),
      itemCount: product.length,
    );
  }
}

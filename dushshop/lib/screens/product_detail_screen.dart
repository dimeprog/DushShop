import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product_detail_screen';

  @override
  Widget build(BuildContext context) {
    final _productId = ModalRoute.of(context)?.settings.arguments;
    final productId = _productId.toString();

    final loadedproduct =
        Provider.of<ProductProvider>(context).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedproduct.title),
      ),
    );
  }
}
